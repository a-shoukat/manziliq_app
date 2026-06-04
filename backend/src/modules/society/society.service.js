const { supabaseAdmin } = require('../../config/supabase');

async function createSociety(ownerId, payload) {
  return supabaseAdmin.from('societies').insert({ owner_id: ownerId, ...payload }).select().single();
}

async function getSocieties(filters = {}) {
  let q = supabaseAdmin.from('societies').select('*, plots(count)');
  if (filters.city) q = q.eq('city', filters.city);
  return q;
}

async function uploadPlotsCsv(societyId, rows) {
  const plots = rows.map((r) => ({
    society_id: societyId,
    plot_number: r.plot_number,
    block: r.block,
    size_value: r.size_value,
    size_unit: r.size_unit || 'marla',
    category: r.category || 'residential',
    price_pkr: r.price_pkr,
    svg_zone_id: r.svg_zone_id,
  }));
  return supabaseAdmin.from('plots').insert(plots).select();
}

async function reviewDealerRequest(requestId, status, reviewerId) {
  return supabaseAdmin
    .from('dealer_society_requests')
    .update({ status, reviewed_by: reviewerId })
    .eq('id', requestId)
    .select()
    .single();
}

module.exports = { createSociety, getSocieties, uploadPlotsCsv, reviewDealerRequest };
