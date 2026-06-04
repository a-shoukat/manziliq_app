const { supabaseAdmin } = require('../../config/supabase');

async function register(req, res) {
  const { email, password, fullName, phone, role, metadata } = req.body;

  const { data, error } = await supabaseAdmin.auth.admin.createUser({
    email,
    password,
    email_confirm: false,
    user_metadata: { full_name: fullName, role, ...metadata },
  });

  if (error) return res.status(400).json({ error: error.message });

  await supabaseAdmin.from('profiles').update({
    full_name: fullName,
    phone,
    role,
    ...metadata,
  }).eq('id', data.user.id);

  return res.status(201).json({ user: data.user, message: 'Registration submitted for admin approval' });
}

async function login(req, res) {
  const { email, password } = req.body;
  const { data, error } = await supabaseAdmin.auth.signInWithPassword({ email, password });
  if (error) return res.status(400).json({ error: error.message });

  const { data: profile } = await supabaseAdmin
    .from('profiles')
    .select('*')
    .eq('id', data.user.id)
    .single();

  return res.json({ session: data.session, profile });
}

async function getProfile(req, res) {
  return res.json(req.profile);
}

async function approveUser(req, res) {
  const { userId, status, rejectionReason } = req.body;
  const { data, error } = await supabaseAdmin
    .from('profiles')
    .update({
      approval_status: status,
      rejection_reason: rejectionReason || null,
      approved_by: req.user.id,
      approved_at: status === 'approved' ? new Date().toISOString() : null,
    })
    .eq('id', userId)
    .select()
    .single();

  if (error) return res.status(400).json({ error: error.message });

  await supabaseAdmin.from('notifications').insert({
    user_id: userId,
    title: status === 'approved' ? 'Account Approved' : 'Account Rejected',
    body: status === 'approved'
      ? 'Your ManzilIQ account has been approved. You can now log in.'
      : `Your registration was rejected: ${rejectionReason || 'Contact support'}`,
    type: 'approval_pending',
  });

  return res.json(data);
}

async function listPendingUsers(req, res) {
  const { data, error } = await supabaseAdmin
    .from('profiles')
    .select('*')
    .eq('approval_status', 'pending')
    .order('created_at', { ascending: false });

  if (error) return res.status(400).json({ error: error.message });
  return res.json(data);
}

async function uploadDocument(req, res) {
  const { userId, bucket, path, fileBase64, contentType } = req.body;
  const buffer = Buffer.from(fileBase64, 'base64');
  const { data, error } = await supabaseAdmin.storage
    .from(bucket)
    .upload(path, buffer, { contentType, upsert: true });

  if (error) return res.status(400).json({ error: error.message });
  const { data: urlData } = supabaseAdmin.storage.from(bucket).getPublicUrl(data.path);
  return res.json({ url: urlData.publicUrl, path: data.path });
}

module.exports = { register, login, getProfile, approveUser, listPendingUsers, uploadDocument };
