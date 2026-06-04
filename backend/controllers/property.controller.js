const supabase = require("../config/supabase");

// Get all properties
exports.getProperties = async (req, res) => {
  const { data, error } = await supabase
    .from("properties")
    .select("*");

  if (error) return res.status(400).json({ error: error.message });

  res.json(data);
};

// Create property
exports.createProperty = async (req, res) => {
  const { data, error } = await supabase
    .from("properties")
    .insert([req.body]);

  if (error) return res.status(400).json({ error: error.message });

  res.json(data);
};