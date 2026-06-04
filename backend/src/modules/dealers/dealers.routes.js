const express = require('express');
const router = express.Router();
const ctrl = require('./dealers.controller');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

router.get('/dashboard', authMiddleware, roleMiddleware('dealer'), ctrl.dashboard);
router.post('/lots/request', authMiddleware, roleMiddleware('dealer'), ctrl.requestLot);

module.exports = router;
