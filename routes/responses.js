const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/responseController');

router.get('/ticket/:id_tiket', ctrl.getByTicket);
router.post('/', ctrl.add);
router.delete('/:id', ctrl.delete);

module.exports = router;