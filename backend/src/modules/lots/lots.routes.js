const express = require('express');
const router = express.Router();
const ctrl = require('./lots.controller');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

router.post('/assign', authMiddleware, roleMiddleware('society'), ctrl.assign);
router.post('/release', authMiddleware, roleMiddleware('society', 'dealer'), ctrl.release);

module.exports = router;
