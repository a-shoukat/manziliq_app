-- Payments & installments

CREATE TYPE payment_method AS ENUM (
  'jazzcash', 'easypaisa', 'bank_transfer', 'cash', 'cheque'
);
CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed', 'overdue');
CREATE TYPE installment_plan_type AS ENUM (
  'lump_sum', 'one_year', 'three_year', 'five_year', 'custom'
);

CREATE TABLE IF NOT EXISTS public.payment_schedules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id) ON DELETE CASCADE,
  plan_type installment_plan_type NOT NULL,
  total_amount_pkr NUMERIC(15,2) NOT NULL,
  down_payment_pkr NUMERIC(15,2) DEFAULT 0,
  num_installments INT DEFAULT 0,
  monthly_amount_pkr NUMERIC(15,2),
  late_fee_percent NUMERIC(5,2) DEFAULT 2.00,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id),
  schedule_id UUID REFERENCES public.payment_schedules(id),
  amount_pkr NUMERIC(15,2) NOT NULL,
  method payment_method NOT NULL,
  status payment_status NOT NULL DEFAULT 'pending',
  due_date DATE,
  paid_at TIMESTAMPTZ,
  late_fee_pkr NUMERIC(15,2) DEFAULT 0,
  receipt_url TEXT,
  transaction_ref TEXT,
  installment_number INT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_payments_booking ON public.payments(booking_id);
CREATE INDEX idx_payments_due ON public.payments(due_date);
CREATE INDEX idx_payments_status ON public.payments(status);
