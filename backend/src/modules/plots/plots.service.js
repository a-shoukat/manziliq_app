const { supabaseAdmin } = require('../../config/supabase');

async function searchPlots(filters) {
  let q = supabaseAdmin.from('plots').select('*, societies(name, city, area)');
  if (filters.society_id) q = q.eq('society_id', filters.society_id);
  if (filters.block) q = q.eq('block', filters.block);
  if (filters.status) q = q.eq('status', filters.status);
  if (filters.min_price) q = q.gte('price_pkr', filters.min_price);
  if (filters.max_price) q = q.lte('price_pkr', filters.max_price);
  if (filters.sort === 'price_asc') q = q.order('price_pkr', { ascending: true });
  else if (filters.sort === 'price_desc') q = q.order('price_pkr', { ascending: false });
  else q = q.order('created_at', { ascending: false });
  return q;
}

async function updatePlotStatus(plotId, status, dealerId) {
  return supabaseAdmin
    .from('plots')
    .update({ status, assigned_dealer_id: dealerId })
    .eq('id', plotId)
    .select()
    .single();
}

module.exports = { searchPlots, updatePlotStatus };
