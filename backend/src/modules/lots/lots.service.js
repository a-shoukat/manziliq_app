const { supabaseAdmin } = require('../../config/supabase');

async function assignLotToDealer(societyId, dealerId, plotIds, lotPayload, performedBy) {
  const { data: lot, error: lotErr } = await supabaseAdmin
    .from('lots')
    .insert({ society_id: societyId, dealer_id: dealerId, ...lotPayload })
    .select()
    .single();
  if (lotErr) return { error: lotErr };

  const { error: plotErr } = await supabaseAdmin
    .from('plots')
    .update({ lot_id: lot.id, assigned_dealer_id: dealerId, status: 'assigned' })
    .in('id', plotIds);
  if (plotErr) return { error: plotErr };

  const auditRows = plotIds.map((plotId) => ({
    lot_id: lot.id,
    plot_id: plotId,
    dealer_id: dealerId,
    action: 'assigned',
    performed_by: performedBy,
  }));
  await supabaseAdmin.from('lot_assignments_audit').insert(auditRows);
  return { data: lot };
}

async function releaseLot(lotId, performedBy) {
  await supabaseAdmin.from('plots').update({
    lot_id: null,
    assigned_dealer_id: null,
    status: 'available',
  }).eq('lot_id', lotId);

  return supabaseAdmin.from('lots').update({ status: 'released' }).eq('id', lotId).select().single();
}

module.exports = { assignLotToDealer, releaseLot };
