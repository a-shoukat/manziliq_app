-- Bookings & deal pipeline (6 stages)

CREATE TYPE booking_type AS ENUM ('direct_society', 'dealer_assisted');
CREATE TYPE deal_stage AS ENUM (
  'inquiry',
  'site_visit',
  'token_received',
  'agreement_signed',
  'payment_active',
  'transfer_submitted'
);
CREATE TYPE booking_status AS ENUM ('pending', 'approved', 'rejected', 'cancelled', 'completed');

CREATE TABLE IF NOT EXISTS public.bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reference_number TEXT NOT NULL UNIQUE,
  plot_id UUID NOT NULL REFERENCES public.plots(id),
  customer_id UUID NOT NULL REFERENCES public.profiles(id),
  dealer_id UUID REFERENCES public.profiles(id),
  society_id UUID NOT NULL REFERENCES public.societies(id),
  booking_type booking_type NOT NULL DEFAULT 'dealer_assisted',
  current_stage deal_stage NOT NULL DEFAULT 'inquiry',
  status booking_status NOT NULL DEFAULT 'pending',
  token_amount_pkr NUMERIC(15,2),
  installment_plan TEXT,
  site_visit_date TIMESTAMPTZ,
  notes TEXT,
  approved_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.deal_stage_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id) ON DELETE CASCADE,
  stage deal_stage NOT NULL,
  changed_by UUID REFERENCES public.profiles(id),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_bookings_customer ON public.bookings(customer_id);
CREATE INDEX idx_bookings_dealer ON public.bookings(dealer_id);
CREATE INDEX idx_bookings_society ON public.bookings(society_id);
CREATE INDEX idx_bookings_stage ON public.bookings(current_stage);

CREATE TRIGGER bookings_updated_at
  BEFORE UPDATE ON public.bookings
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
