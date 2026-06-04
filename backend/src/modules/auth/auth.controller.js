const authService = require('./auth.service');
const authMiddleware = require('../../middleware/auth.middleware');
const roleMiddleware = require('../../middleware/role.middleware');

async function register(req, res) {
  try {
    await authService.register(req, res);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
}

async function login(req, res) {
  try {
    await authService.login(req, res);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
}

async function me(req, res) {
  authService.getProfile(req, res);
}

async function approveUser(req, res) {
  authService.approveUser(req, res);
}

async function listPending(req, res) {
  authService.listPendingUsers(req, res);
}

async function uploadDoc(req, res) {
  authService.uploadDocument(req, res);
}

module.exports = { register, login, me, approveUser, listPending, uploadDoc };
