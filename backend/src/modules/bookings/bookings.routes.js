const express = require('express');
const router = express.Router();
const ctrl = require('./bookings.controller');
const authMiddleware = require('../../middleware/auth.middleware');

router.post('/', authMiddleware, ctrl.create);
router.post('/advance-stage', authMiddleware, ctrl.advance);
router.post('/payment-schedule', authMiddleware, ctrl.schedule);

module.exports = router;
