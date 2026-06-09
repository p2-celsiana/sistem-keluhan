const db = require('../config/db');

exports.getMetrics = async (req, res) => {
  try {
    // 1. WAKTU RESOLUSI (Rata-rata jam tiket 'Selesai')
    // Rumus: (Sekarang - Tanggal Dibuat) untuk tiket yang sudah Selesai
    const [waktuResolusi] = await db.execute(`
      SELECT 
        IFNULL(AVG(TIMESTAMPDIFF(HOUR, tgl_keluhan, NOW())), 0) as rata_jam,
        COUNT(CASE WHEN status = 'Selesai' THEN 1 END) as total_selesai
      FROM tiket_keluhan WHERE status = 'Selesai'
    `);

    // 2. KATEGORI DOMINAN (Untuk Chart)
    const [kategoriDominan] = await db.execute(`
      SELECT kategori, COUNT(*) as jumlah 
      FROM tiket_keluhan 
      GROUP BY kategori 
      ORDER BY jumlah DESC
    `);

    // 3. KEPUASAN (Rating Rata-rata)
    const [kepuasan] = await db.execute(`
      SELECT 
        IFNULL(AVG(rating_kepuasan), 0) as rata_rating,
        COUNT(CASE WHEN rating_kepuasan >= 4 THEN 1 END) as jumlah_puas
      FROM tiket_keluhan 
      WHERE rating_kepuasan IS NOT NULL
    `);

    // 4. TOTAL TIKET & BARU (Untuk Card Samping)
    const [summary] = await db.execute(`
      SELECT 
        COUNT(*) as total,
        COUNT(CASE WHEN status = 'Baru' THEN 1 END) as baru
      FROM tiket_keluhan
    `);

    res.json({
      waktu_resolusi: waktuResolusi[0], // { rata_jam: 12.5, total_selesai: 10 }
      kategori_dominan: kategoriDominan, // [{kategori: 'Teknis', jumlah: 5}, ...]
      kepuasan: kepuasan[0],            // { rata_rating: 4.5, jumlah_puas: 8 }
      summary: summary[0]               // { total: 20, baru: 3 }
    });

  } catch (err) {
    console.error('❌ Dashboard Error:', err);
    res.status(500).json({ error: 'Gagal ambil data dashboard' });
  }
};