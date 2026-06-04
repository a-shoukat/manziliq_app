const service = require('./documents.service');
const authMiddleware = require('../../middleware/auth.middleware');

async function locker(req, res) {
  const { data, error } = await service.getLocker(req.user.id);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function generate(req, res) {
  const { bookingId, docType, title, fileUrl } = req.body;
  const { data, error } = await service.generateDocument(req.user.id, bookingId, docType, title, fileUrl);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

module.exports = { locker, generate };
