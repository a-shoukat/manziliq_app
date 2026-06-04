-- In-app notifications (Supabase Realtime — no Firebase)

CREATE TYPE notification_channel AS ENUM ('in_app', 'email', 'sms');
CREATE TYPE notification_type AS ENUM (
  'booking_created', 'booking_approved', 'payment_due',
  'payment_received', 'transfer_approved', 'document_ready',
  'approval_pending', 'broadcast', 'system'
);

CREATE TABLE IF NOT EXISTS public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  type notification_type NOT NULL DEFAULT 'system',
  channel notification_channel NOT NULL DEFAULT 'in_app',
  is_read BOOLEAN DEFAULT FALSE,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.disputes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plot_id UUID NOT NULL REFERENCES public.plots(id),
  raised_by UUID NOT NULL REFERENCES public.profiles(id),
  against_user UUID REFERENCES public.profiles(id),
  description TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'frozen', 'mediating', 'resolved', 'escalated')),
  resolution TEXT,
  resolved_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON public.notifications(user_id);
CREATE INDEX idx_notifications_unread ON public.notifications(user_id, is_read);

CREATE TRIGGER disputes_updated_at
  BEFORE UPDATE ON public.disputes
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
