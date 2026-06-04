const service = require('./dealers.service');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

async function dashboard(req, res) {
  const { data } = await service.getDealerDashboard(req.user.id);
  res.json(data);
}

async function requestLot(req, res) {
  const { societyId, ...payload } = req.body;
  const { data, error } = await service.requestLot(req.user.id, societyId, payload);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

module.exports = { dashboard, requestLot };
