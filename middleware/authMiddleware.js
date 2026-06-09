const jwt = require('jsonwebtoken');

// 🔑 HARUS SAMA PERSIS dengan authController.js
const JWT_SECRET = process.env.JWT_SECRET || 'sistem_keluhan_super_secret';

exports.verifyToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // "Bearer TOKEN"

  if (!token) return res.status(401).json({ error: 'Token tidak ada' });

  try {
    const verified = jwt.verify(token, JWT_SECRET);
    req.user = verified; // ✅ Ini yang bikin req.user.email tersedia di controller
    next();
  } catch (err) {
    return res.status(403).json({ error: 'Token tidak valid' });
  }
};