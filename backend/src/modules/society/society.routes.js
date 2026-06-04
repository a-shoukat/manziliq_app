const express = require('express');
const router = express.Router();
const ctrl = require('./society.controller');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

router.get('/', ctrl.list);
router.post('/', authMiddleware, roleMiddleware('society', 'admin'), ctrl.create);
router.post('/plots/bulk', authMiddleware, roleMiddleware('society'), ctrl.bulkUpload);
router.post('/dealer-requests/review', authMiddleware, roleMiddleware('society'), ctrl.approveDealer);

module.exports = router;
