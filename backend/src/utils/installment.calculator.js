function calculateInstallments(planType, totalAmount, downPayment = 0) {
  const remaining = totalAmount - downPayment;
  const plans = {
    lump_sum: { numInstallments: 0, months: 0 },
    one_year: { numInstallments: 12, months: 12 },
    three_year: { numInstallments: 36, months: 36 },
    five_year: { numInstallments: 60, months: 60 },
    custom: { numInstallments: 24, months: 24 },
  };
  const plan = plans[planType] || plans.custom;
  const monthlyAmount = plan.numInstallments > 0 ? Math.ceil(remaining / plan.numInstallments) : remaining;
  return { numInstallments: plan.numInstallments, monthlyAmount, remaining };
}

module.exports = { calculateInstallments };
