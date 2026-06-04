function roleMiddleware(...allowedRoles) {
  return (req, res, next) => {
    if (!req.profile) {
      return res.status(401).json({ error: 'Not authenticated' });
    }
    if (!allowedRoles.includes(req.profile.role)) {
      return res.status(403).json({ error: 'Access denied for this role' });
    }
    if (req.profile.approval_status !== 'approved' && req.profile.role !== 'admin') {
      return res.status(403).json({ error: 'Account pending admin approval' });
    }
    next();
  };
}

module.exports = roleMiddleware;
