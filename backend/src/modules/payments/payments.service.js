const { supabaseAdmin } = require('../../config/supabase');
const { generateReceiptPdf } = require('../../utils/pdf.generator');

async function recordPayment(payload) {
  const { data, error } = await supabaseAdmin.from('payments').insert(payload).select().single();
  if (error) return { error };

  const receiptUrl = await generateReceiptPdf(data);
  await supabaseAdmin.from('payments').update({ receipt_url: receiptUrl, status: 'completed', paid_at: new Date().toISOString() }).eq('id', data.id);

  return supabaseAdmin.from('payments').select('*').eq('id', data.id).single();
}

async function getOverduePayments() {
  const today = new Date().toISOString().split('T')[0];
  return supabaseAdmin.from('payments').select('*, bookings(*)').eq('status', 'pending').lt('due_date', today);
}

module.exports = { recordPayment, getOverduePayments };
