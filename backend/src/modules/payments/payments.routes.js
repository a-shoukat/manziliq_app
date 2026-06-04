const express = require('express');
const router = express.Router();
const ctrl = require('./payments.controller');
const authMiddleware = require('../../middleware/auth.middleware');

router.post('/', authMiddleware, ctrl.pay);
router.get('/overdue', authMiddleware, ctrl.overdue);

module.exports = router;
