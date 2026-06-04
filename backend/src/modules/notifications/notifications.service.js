const { supabaseAdmin } = require('../../config/supabase');
const { sendSms } = require('../../utils/sms.service');
const { sendEmail } = require('../../utils/email.service');

async function createNotification(userId, title, body, type, channel = 'in_app') {
  const { data, error } = await supabaseAdmin.from('notifications').insert({
    user_id: userId,
    title,
    body,
    type,
    channel,
  }).select().single();

  if (!error && channel === 'sms') await sendSms(userId, body);
  if (!error && channel === 'email') await sendEmail(userId, title, body);
  return { data, error };
}

async function broadcast(senderRole, audience, title, body) {
  let q = supabaseAdmin.from('profiles').select('id');
  if (audience === 'dealers') q = q.eq('role', 'dealer');
  else if (audience === 'customers') q = q.eq('role', 'customer');
  const { data: users } = await q;
  const rows = (users || []).map((u) => ({
    user_id: u.id,
    title,
    body,
    type: 'broadcast',
    channel: 'in_app',
  }));
  return supabaseAdmin.from('notifications').insert(rows).select();
}

async function getInbox(userId) {
  return supabaseAdmin.from('notifications').select('*').eq('user_id', userId).order('created_at', { ascending: false });
}

module.exports = { createNotification, broadcast, getInbox };
