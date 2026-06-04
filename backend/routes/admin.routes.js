const express = require("express");
const router = express.Router();

const controller = require("../controllers/admin.controller");

router.get("/users", controller.getUsers);
router.post("/approve-property", controller.approveProperty);

module.exports = router;