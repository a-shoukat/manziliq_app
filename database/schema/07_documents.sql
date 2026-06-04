-- Legal documents & locker

CREATE TYPE document_type AS ENUM (
  'allotment_letter', 'token_receipt', 'sale_agreement',
  'transfer_deed', 'noc', 'cancellation_letter',
  'cnic', 'society_noc', 'secp_registration', 'agent_license'
);

CREATE TABLE IF NOT EXISTS public.documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES public.profiles(id),
  booking_id UUID REFERENCES public.bookings(id),
  society_id UUID REFERENCES public.societies(id),
  doc_type document_type NOT NULL,
  title TEXT NOT NULL,
  file_url TEXT NOT NULL,
  version INT DEFAULT 1,
  expires_at DATE,
  watermark_applied BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.document_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  doc_type document_type NOT NULL,
  name TEXT NOT NULL,
  template_content TEXT NOT NULL,
  version INT DEFAULT 1,
  is_active BOOLEAN DEFAULT TRUE,
  updated_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_documents_owner ON public.documents(owner_id);
CREATE INDEX idx_documents_booking ON public.documents(booking_id);
