const service = require('./society.service');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

async function list(req, res) {
  const { data, error } = await service.getSocieties(req.query);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function create(req, res) {
  const { data, error } = await service.createSociety(req.user.id, req.body);
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
}

async function bulkUpload(req, res) {
  const { societyId, rows } = req.body;
  const { data, error } = await service.uploadPlotsCsv(societyId, rows);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function approveDealer(req, res) {
  const { requestId, status } = req.body;
  const { data, error } = await service.reviewDealerRequest(requestId, status, req.user.id);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

module.exports = { list, create, bulkUpload, approveDealer };
