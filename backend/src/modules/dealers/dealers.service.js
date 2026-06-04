const { supabaseAdmin } = require('../../config/supabase');

async function getDealerDashboard(dealerId) {
  const lots = await supabaseAdmin.from('lots').select('*').eq('dealer_id', dealerId);
  const plots = await supabaseAdmin.from('plots').select('*').eq('assigned_dealer_id', dealerId);
  const bookings = await supabaseAdmin.from('bookings').select('*').eq('dealer_id', dealerId);
  return { lots: lots.data, plots: plots.data, bookings: bookings.data };
}

async function requestLot(dealerId, societyId, payload) {
  return supabaseAdmin.from('lots').insert({
    dealer_id: dealerId,
    society_id: societyId,
    ...payload,
  }).select().single();
}

module.exports = { getDealerDashboard, requestLot };
