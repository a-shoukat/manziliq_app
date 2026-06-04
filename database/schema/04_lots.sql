-- Lot assignment batches

CREATE TYPE lot_status AS ENUM ('active', 'expired', 'released');

CREATE TABLE IF NOT EXISTS public.lots (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  society_id UUID NOT NULL REFERENCES public.societies(id) ON DELETE CASCADE,
  dealer_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  block TEXT NOT NULL,
  status lot_status NOT NULL DEFAULT 'active',
  expires_at TIMESTAMPTZ,
  renewal_terms TEXT,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.plots
  ADD CONSTRAINT plots_lot_id_fkey
  FOREIGN KEY (lot_id) REFERENCES public.lots(id) ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS public.lot_assignments_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lot_id UUID NOT NULL REFERENCES public.lots(id) ON DELETE CASCADE,
  plot_id UUID NOT NULL REFERENCES public.plots(id) ON DELETE CASCADE,
  dealer_id UUID NOT NULL REFERENCES public.profiles(id),
  action TEXT NOT NULL CHECK (action IN ('assigned', 'released', 'reserved', 'sold')),
  performed_by UUID REFERENCES public.profiles(id),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_lots_dealer ON public.lots(dealer_id);
CREATE INDEX idx_lot_audit_lot ON public.lot_assignments_audit(lot_id);

CREATE TRIGGER lots_updated_at
  BEFORE UPDATE ON public.lots
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
