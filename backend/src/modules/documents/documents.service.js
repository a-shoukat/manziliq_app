const { supabaseAdmin } = require('../../config/supabase');

async function generateDocument(ownerId, bookingId, docType, title, fileUrl) {
  return supabaseAdmin.from('documents').insert({
    owner_id: ownerId,
    booking_id: bookingId,
    doc_type: docType,
    title,
    file_url: fileUrl,
    watermark_applied: true,
  }).select().single();
}

async function getLocker(ownerId) {
  return supabaseAdmin.from('documents').select('*').eq('owner_id', ownerId).order('created_at', { ascending: false });
}

module.exports = { generateDocument, getLocker };
