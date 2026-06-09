const db = require('../config/db');

// ✅ SESUAIKAN NAMA TABEL: pakai 'respon' (sesuai struktur database kamu)

exports.add = async (req, res) => {
  try {
    const { id_tiket, isi_respon, peran, nama_petugas } = req.body;

    if (!id_tiket || !isi_respon?.trim()) {
      return res.status(400).json({ error: 'Isi pesan wajib diisi' });
    }

    // ✅ INSERT ke tabel 'respon' dengan kolom yang sesuai
    await db.execute(
      `INSERT INTO respon (id_tiket, isi_respon, peran, id_user, tgl_respon) 
       VALUES (?, ?, ?, ?, NOW())`,
      [id_tiket, isi_respon.trim(), peran || 'Pelanggan', req.user?.id_user || null]
    );

    res.status(201).json({ message: 'Pesan terkirim' });
  } catch (err) {
    console.error('Send message error:', err);
    res.status(500).json({ error: 'Gagal mengirim pesan: ' + err.message });
  }
};

exports.getByTicket = async (req, res) => {
  try {
    // ✅ SELECT dari tabel 'respon' (sama dengan INSERT)
    const [rows] = await db.execute(`
      SELECT r.*, u.nama as nama_petugas 
      FROM respon r 
      LEFT JOIN user u ON r.id_user = u.id_user 
      WHERE r.id_tiket = ? 
      ORDER BY r.tgl_respon ASC`, 
      [req.params.id_tiket]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get responses error:', err);
    res.status(500).json({ error: 'Gagal ambil thread: ' + err.message });
  }
};

exports.delete = async (req, res) => {
  try {
    await db.execute(`DELETE FROM respon WHERE id_respon=?`, [req.params.id]);
    res.json({ message: 'Respon dihapus' });
  } catch (err) {
    console.error('Delete response error:', err);
    res.status(500).json({ error: 'Gagal hapus respon: ' + err.message });
  }
};