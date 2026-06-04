module.exports = function (roles) {
  return (req, res, next) => {
    const userRole = req.headers["role"];

    if (!roles.includes(userRole)) {
      return res.status(403).json({ message: "Access denied" });
    }

    next();
  };
};