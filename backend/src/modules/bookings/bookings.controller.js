const service = require('./bookings.service');
const authMiddleware = require('../../middleware/auth.middleware');

async function create(req, res) {
  const { data, error } = await service.createBooking({ ...req.body, customer_id: req.user.id });
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

async function advance(req, res) {
  const { bookingId, stage, notes } = req.body;
  const { data, error } = await service.advanceStage(bookingId, stage, req.user.id, notes);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function schedule(req, res) {
  const { bookingId, planType, totalAmount, downPayment } = req.body;
  const { data, error } = await service.createSchedule(bookingId, planType, totalAmount, downPayment);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

module.exports = { create, advance, schedule };
