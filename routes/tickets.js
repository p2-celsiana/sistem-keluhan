const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/ticketController'); // Import Controller
const { verifyToken } = require('../middleware/authMiddleware');

// Definisi Routes (Hubungkan URL ke Fungsi Controller)
router.get('/', verifyToken, ctrl.getAll);
router.get('/:id', verifyToken, ctrl.getById);
router.post('/', verifyToken, ctrl.create);
router.put('/:id', verifyToken, ctrl.update);   // ✅ Ini yang akan memanggil fungsi update di controller
router.delete('/:id', verifyToken, ctrl.delete);

// ✅ WAJIB: Export router
module.exports = router;