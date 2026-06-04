const service = require('./plots.service');

async function search(req, res) {
  const { data, error } = await service.searchPlots(req.query);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

async function updateStatus(req, res) {
  const { plotId, status } = req.body;
  const { data, error } = await service.updatePlotStatus(plotId, status, req.profile?.id);
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
}

module.exports = { search, updateStatus };
