-- Row Level Security policies for ManzilIQ (Supabase)

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.societies ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.plots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.disputes ENABLE ROW LEVEL SECURITY;

-- Helper: get current user role
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.is_approved()
RETURNS BOOLEAN AS $$
  SELECT approval_status = 'approved' FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Profiles
CREATE POLICY "Users read own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Admin read all profiles"
  ON public.profiles FOR SELECT
  USING (public.get_my_role() = 'admin');

CREATE POLICY "Admin update profiles"
  ON public.profiles FOR UPDATE
  USING (public.get_my_role() = 'admin');

-- Societies: public read for approved customers
CREATE POLICY "Anyone read active societies"
  ON public.societies FOR SELECT
  USING (is_active = TRUE);

CREATE POLICY "Society owner manage"
  ON public.societies FOR ALL
  USING (owner_id = auth.uid());

-- Plots: customers see available; dealers see assigned lots
CREATE POLICY "Public read available plots"
  ON public.plots FOR SELECT
  USING (status IN ('available', 'reserved') OR public.is_approved());

CREATE POLICY "Society manage own plots"
  ON public.plots FOR ALL
  USING (
    society_id IN (SELECT id FROM public.societies WHERE owner_id = auth.uid())
  );

CREATE POLICY "Dealer read assigned plots"
  ON public.plots FOR SELECT
  USING (assigned_dealer_id = auth.uid());

-- Notifications
CREATE POLICY "Users read own notifications"
  ON public.notifications FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users update own notifications"
  ON public.notifications FOR UPDATE
  USING (user_id = auth.uid());

-- Documents locker
CREATE POLICY "Users read own documents"
  ON public.documents FOR SELECT
  USING (owner_id = auth.uid());

CREATE POLICY "Admin read all documents"
  ON public.documents FOR SELECT
  USING (public.get_my_role() = 'admin');

-- Bookings
CREATE POLICY "Customer read own bookings"
  ON public.bookings FOR SELECT
  USING (customer_id = auth.uid() OR dealer_id = auth.uid());

CREATE POLICY "Customer create booking"
  ON public.bookings FOR INSERT
  WITH CHECK (customer_id = auth.uid() AND public.is_approved());

-- Payments
CREATE POLICY "Users read related payments"
  ON public.payments FOR SELECT
  USING (
    booking_id IN (
      SELECT id FROM public.bookings
      WHERE customer_id = auth.uid() OR dealer_id = auth.uid()
    )
  );

-- Storage buckets (run separately in Supabase dashboard or via API)
-- documents, society-maps, cnic-uploads
