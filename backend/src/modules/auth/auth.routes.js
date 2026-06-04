const express = require('express');
const router = express.Router();
const ctrl = require('./auth.controller');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

router.post('/register', ctrl.register);
router.post('/login', ctrl.login);
router.get('/me', authMiddleware, ctrl.me);
router.post('/upload-document', authMiddleware, ctrl.uploadDoc);
router.get('/pending', authMiddleware, roleMiddleware('admin'), ctrl.listPending);
router.post('/approve', authMiddleware, roleMiddleware('admin'), ctrl.approveUser);

module.exports = router;
