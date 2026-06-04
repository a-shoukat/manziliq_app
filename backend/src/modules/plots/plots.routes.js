const express = require('express');
const router = express.Router();
const ctrl = require('./plots.controller');
const authMiddleware = require('../../middleware/auth.middleware');

router.get('/search', ctrl.search);
router.patch('/status', authMiddleware, ctrl.updateStatus);

module.exports = router;
