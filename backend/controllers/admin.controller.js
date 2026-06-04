const supabase = require("../config/supabase");

// Get all users
exports.getUsers = async (req, res) => {
  const { data, error } = await supabase
    .from("profiles")
    .select("*");

  if (error) return res.status(400).json({ error: error.message });

  res.json(data);
};

// Approve property
exports.approveProperty = async (req, res) => {
  const { id } = req.body;

  const { data, error } = await supabase
    .from("properties")
    .update({ status: "approved" })
    .eq("id", id);

  if (error) return res.status(400).json({ error: error.message });

  res.json(data);
};