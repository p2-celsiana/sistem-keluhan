const db = require('../config/db');

const VALID = {
  kategori: ['Teknis', 'Billing', 'Layanan', 'Produk', 'Lainnya'],
  prioritas: ['Low', 'Medium', 'High'],
  status: ['Baru', 'Diproses', 'Menunggu', 'Selesai']
};

exports.create = async (req, res) => {
  const { nama_pelanggan, email, no_hp, kategori, prioritas, deskripsi } = req.body;

  if (!nama_pelanggan || !kategori || !deskripsi) {
    return res.status(400).json({ error: 'Nama, kategori, dan deskripsi wajib diisi' });
  }
  if (!VALID.kategori.includes(kategori)) {
    return res.status(400).json({ error: 'Kategori tidak valid' });
  }

  try {
    const [t] = await db.execute(
      `INSERT INTO tiket_keluhan (nama_pelanggan, email, no_hp, kategori, prioritas, deskripsi, status) 
       VALUES (?, ?, ?, ?, ?, ?, 'Baru')`,
      [nama_pelanggan, email || null, no_hp || null, kategori, prioritas || 'Medium', deskripsi]
    );

    const tid = t.insertId;
    const jam = { High: 4, Medium: 24, Low: 48 }[prioritas] || 24;

    await db.execute(
      `INSERT INTO status_sla (id_tiket, waktu_maksimal, status_sla, dibuat) 
       VALUES (?, DATE_ADD(NOW(), INTERVAL ? HOUR), 'Belum selesai', NOW())`,
      [tid, jam]
    );

    res.status(201).json({ message: 'Tiket berhasil dibuat', id_tiket: tid });
  } catch (err) {
    console.error('❌ Error create ticket:', err);
    res.status(500).json({ error: 'Gagal membuat tiket', detail: err.message });
  }
};

exports.getAll = async (req, res) => {
  try {
    const { role, email } = req.user; // Ambil role & email dari token JWT
    let query = 'SELECT * FROM tiket_keluhan';
    let params = [];

    // ✅ FILTER: Jika bukan Admin/CS, hanya tampilkan tiket milik email yang login
    if (!['Admin', 'CS', 'admin', 'cs'].includes(role)) {
      query += ' WHERE email = ?'; 
      params.push(email);
    }

    query += ' ORDER BY tgl_keluhan DESC';
    
    const [rows] = await db.execute(query, params);
    res.json(rows);
  } catch (err) {
    console.error('Get tickets error:', err);
    res.status(500).json({ error: 'Gagal mengambil data tiket' });
  }
};

exports.getById = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT t.*, s.* FROM tiket_keluhan t 
       LEFT JOIN status_sla s ON t.id_tiket = s.id_tiket 
       WHERE t.id_tiket = ?`,
      [req.params.id]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Tiket tidak ditemukan' });
    }
    res.json(rows[0]);
  } catch (err) {
    console.error('❌ Error get ticket:', err);
    res.status(500).json({ error: 'Gagal mengambil detail', detail: err.message });
  }
};

exports.update = async (req, res) => {
  const { id } = req.params;
  const { status, rating_kepuasan } = req.body;

  const ticketId = Number(id);
  if (isNaN(ticketId)) {
    return res.status(400).json({ error: 'ID tiket tidak valid' });
  }

  if (!status || !VALID.status.includes(status)) {
    return res.status(400).json({ error: 'Status wajib diisi dan harus valid' });
  }

  let ratingValue = null;
  if (rating_kepuasan !== undefined && rating_kepuasan !== null && rating_kepuasan !== '') {
    ratingValue = parseInt(rating_kepuasan, 10);
    if (isNaN(ratingValue) || ratingValue < 1 || ratingValue > 5) {
      return res.status(400).json({ error: 'Rating harus angka 1-5' });
    }
  }

  try {
    const [result] = await db.execute(
      'UPDATE tiket_keluhan SET status = ?, rating_kepuasan = ? WHERE id_tiket = ?',
      [status, ratingValue, ticketId]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Tiket tidak ditemukan' });
    }

    res.json({ message: 'Status berhasil diupdate' });
    
  } catch (err) {
    console.error('❌ Update Error:', err);
    res.status(500).json({ error: 'Gagal update tiket', detail: err.message });
  }
};

exports.delete = async (req, res) => {
  try {
    await db.execute(`DELETE FROM tiket_keluhan WHERE id_tiket = ?`, [req.params.id]);
    res.json({ message: 'Tiket berhasil dihapus' });
  } catch (err) {
    console.error('❌ Error delete ticket:', err);
    res.status(500).json({ error: 'Gagal hapus tiket', detail: err.message });
  }
};