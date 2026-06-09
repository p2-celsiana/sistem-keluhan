const db = require('../config/db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// 🔑 Kunci Rahasia - HARUS SAMA dengan yang di middleware/authMiddleware.js
const JWT_SECRET = process.env.JWT_SECRET || 'sistem_keluhan_super_secret';

// ==================== REGISTER ====================
exports.register = async (req, res) => {
  const { nama, email, password, role } = req.body;

  if (!nama || !email || !password) {
    return res.status(400).json({ error: 'Nama, email, dan password wajib diisi' });
  }

  try {
    // Cek email sudah terdaftar atau belum
    const [existing] = await db.execute('SELECT id_user FROM user WHERE email = ?', [email]);
    if (existing.length > 0) {
      return res.status(400).json({ error: 'Email sudah terdaftar' });
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Insert ke database
    await db.execute(
      'INSERT INTO user (nama, email, password, role) VALUES (?, ?, ?, ?)',
      [nama, email, hashedPassword, role || 'Pelanggan'] // Default role Pelanggan untuk form publik
    );

    res.status(201).json({ message: 'Akun berhasil dibuat! Silakan login.' });
  } catch (err) {
    console.error('❌ Register error:', err);
    res.status(500).json({ error: 'Gagal mendaftar', detail: err.message });
  }
};

// ==================== LOGIN ====================
exports.login = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'Email dan password wajib diisi' });
  }

  try {
    // Cari user berdasarkan email
    const [rows] = await db.execute('SELECT * FROM user WHERE email = ?', [email]);
    if (rows.length === 0) {
      return res.status(400).json({ error: 'Email atau password salah' });
    }

    const user = rows[0];

    // Cek password
    const validPass = await bcrypt.compare(password, user.password);
    if (!validPass) {
      return res.status(400).json({ error: 'Email atau password salah' });
    }

    // ✅ BUAT TOKEN JWT - EMAIL DISELIPKAN DI PAYLOAD (PENTING UNTUK FILTER)
    const token = jwt.sign(
      { 
        id: user.id_user,      // ID user
        nama: user.nama,       // Nama user
        role: user.role,       // Role: Admin/CS/Pelanggan
        email: user.email      // 🔑 EMAIL: Wajib ada agar filter tiket user bekerja!
      },
      JWT_SECRET,              // Harus sama dengan di middleware
      { expiresIn: '24h' }     // Token berlaku 24 jam
    );

    // Kirim response ke frontend
    res.json({
      message: 'Login berhasil!',
      token: token,            // Token untuk disimpan di localStorage
      user: { 
        nama: user.nama, 
        role: user.role,
        email: user.email      // Opsional: kirim juga ke frontend untuk info
      }
    });

  } catch (err) {
    console.error('❌ Login error:', err);
    res.status(500).json({ error: 'Error server', detail: err.message });
  }
};

// ==================== GET PROFILE (Opsional) ====================
exports.getProfile = async (req, res) => {
  try {
    // req.user sudah tersedia karena middleware verifyToken
    const [rows] = await db.execute(
      'SELECT id_user, nama, email, role, created_at FROM user WHERE id_user = ?',
      [req.user.id]
    );
    
    if (rows.length === 0) {
      return res.status(404).json({ error: 'User tidak ditemukan' });
    }
    
    res.json(rows[0]);
  } catch (err) {
    console.error('❌ Get profile error:', err);
    res.status(500).json({ error: 'Gagal mengambil profil' });
  }
};