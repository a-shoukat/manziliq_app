const service = require('./notifications.service');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

async function inbox(req, res) {
  const { data, error } = await service.getInbox(req.user.id);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function broadcast(req, res) {
  const { audience, title, body } = req.body;
  const { data, error } = await service.broadcast(req.profile.role, audience, title, body);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

module.exports = { inbox, broadcast };
