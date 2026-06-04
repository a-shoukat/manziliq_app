-- Plot inventory

CREATE TYPE plot_status AS ENUM ('available', 'assigned', 'reserved', 'sold', 'disputed');
CREATE TYPE plot_size_unit AS ENUM ('marla', 'kanal');
CREATE TYPE plot_category AS ENUM ('residential', 'commercial', 'corner', 'park_facing');

CREATE TABLE IF NOT EXISTS public.plots (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  society_id UUID NOT NULL REFERENCES public.societies(id) ON DELETE CASCADE,
  plot_number TEXT NOT NULL,
  block TEXT NOT NULL,
  size_value NUMERIC(10,2) NOT NULL,
  size_unit plot_size_unit NOT NULL DEFAULT 'marla',
  category plot_category NOT NULL DEFAULT 'residential',
  price_pkr NUMERIC(15,2) NOT NULL,
  status plot_status NOT NULL DEFAULT 'available',
  svg_zone_id TEXT,
  assigned_dealer_id UUID REFERENCES public.profiles(id),
  lot_id UUID,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(society_id, block, plot_number)
);

CREATE INDEX idx_plots_society ON public.plots(society_id);
CREATE INDEX idx_plots_status ON public.plots(status);
CREATE INDEX idx_plots_block ON public.plots(block);
CREATE INDEX idx_plots_dealer ON public.plots(assigned_dealer_id);

CREATE TRIGGER plots_updated_at
  BEFORE UPDATE ON public.plots
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
