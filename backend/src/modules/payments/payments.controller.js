const service = require('./payments.service');
const authMiddleware = require('../../middleware/auth.middleware');

async function pay(req, res) {
  const { data, error } = await service.recordPayment(req.body);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data.data);
}

async function overdue(req, res) {
  const { data, error } = await service.getOverduePayments();
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

module.exports = { pay, overdue };
