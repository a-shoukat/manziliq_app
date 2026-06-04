const { supabaseAdmin } = require('../../config/supabase');
const { calculateInstallments } = require('../../utils/installment.calculator');

const STAGES = ['inquiry', 'site_visit', 'token_received', 'agreement_signed', 'payment_active', 'transfer_submitted'];

async function createBooking(payload) {
  const ref = `MQ-${Date.now().toString(36).toUpperCase()}`;
  const { data, error } = await supabaseAdmin.from('bookings').insert({
    reference_number: ref,
    ...payload,
  }).select().single();

  if (!error) {
    await supabaseAdmin.from('deal_stage_history').insert({
      booking_id: data.id,
      stage: 'inquiry',
      changed_by: payload.customer_id,
    });
    await supabaseAdmin.from('plots').update({ status: 'reserved' }).eq('id', payload.plot_id);
  }
  return { data, error };
}

async function advanceStage(bookingId, stage, userId, notes) {
  if (!STAGES.includes(stage)) return { error: { message: 'Invalid stage' } };
  const { data, error } = await supabaseAdmin
    .from('bookings')
    .update({ current_stage: stage })
    .eq('id', bookingId)
    .select()
    .single();
  if (!error) {
    await supabaseAdmin.from('deal_stage_history').insert({ booking_id: bookingId, stage, changed_by: userId, notes });
  }
  return { data, error };
}

async function createSchedule(bookingId, planType, totalAmount, downPayment) {
  const calc = calculateInstallments(planType, totalAmount, downPayment);
  return supabaseAdmin.from('payment_schedules').insert({
    booking_id: bookingId,
    plan_type: planType,
    total_amount_pkr: totalAmount,
    down_payment_pkr: downPayment,
    num_installments: calc.numInstallments,
    monthly_amount_pkr: calc.monthlyAmount,
  }).select().single();
}

module.exports = { createBooking, advanceStage, createSchedule, STAGES };
