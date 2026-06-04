const service = require('./lots.service');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

async function assign(req, res) {
  const { societyId, dealerId, plotIds, ...lotPayload } = req.body;
  const { data, error } = await service.assignLotToDealer(
    societyId, dealerId, plotIds, lotPayload, req.user.id
  );
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

async function release(req, res) {
  const { lotId } = req.body;
  const { data, error } = await service.releaseLot(lotId, req.user.id);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

module.exports = { assign, release };
