const express = require('express');
const router = express.Router();
const ctrl = require('./documents.controller');
const authMiddleware = require('../../middleware/auth.middleware');

router.get('/locker', authMiddleware, ctrl.locker);
router.post('/generate', authMiddleware, ctrl.generate);

module.exports = router;
