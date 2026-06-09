const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/authMiddleware');

router.get('/metrics', verifyToken, async (req, res) => {
  try {
    console.log('📊 Fetching dashboard metrics...');
    
    // 1. Total & Baru
    const [summary] = await db.execute(`
      SELECT 
        COUNT(*) as total,
        COUNT(CASE WHEN status = 'Baru' THEN 1 END) as baru
      FROM tiket_keluhan
    `);

    // 2. Waktu Resolusi
    const [waktu] = await db.execute(`
      SELECT 
        IFNULL(AVG(TIMESTAMPDIFF(HOUR, tgl_keluhan, NOW())), 0) as rata_jam,
        COUNT(CASE WHEN status = 'Selesai' THEN 1 END) as total_selesai
      FROM tiket_keluhan 
      WHERE status = 'Selesai'
    `);

    // 3. Kategori
    const [kategori] = await db.execute(`
      SELECT kategori, COUNT(*) as jumlah 
      FROM tiket_keluhan 
      GROUP BY kategori 
      ORDER BY jumlah DESC
    `);

    // 4. Kepuasan
    const [kepuasan] = await db.execute(`
      SELECT 
        IFNULL(AVG(rating_kepuasan), 0) as rata_rating,
        COUNT(CASE WHEN rating_kepuasan >= 4 THEN 1 END) as jumlah_puas
      FROM tiket_keluhan 
      WHERE rating_kepuasan IS NOT NULL
    `);

    const result = {
      summary: summary[0],
      waktu_resolusi: waktu[0],
      kategori_dominan: kategori,
      kepuasan: kepuasan[0]
    };

    console.log('✅ Dashboard data:', result);
    res.json(result);

  } catch (err) {
    console.error('❌ Dashboard Error:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;