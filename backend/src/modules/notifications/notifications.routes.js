const express = require('express');
const router = express.Router();
const ctrl = require('./notifications.controller');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

router.get('/', authMiddleware, ctrl.inbox);
router.post('/broadcast', authMiddleware, roleMiddleware('admin', 'society'), ctrl.broadcast);

module.exports = router;
