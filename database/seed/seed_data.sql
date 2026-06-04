-- Seed data for development (run after schemas)

-- Note: Admin user must be created via Supabase Auth first, then:
-- UPDATE public.profiles SET role = 'admin', approval_status = 'approved'
-- WHERE email = 'admin@manziliq.pk';

INSERT INTO public.societies (id, owner_id, name, city, area, latitude, longitude, description)
SELECT
  'a0000000-0000-0000-0000-000000000001'::uuid,
  id,
  'Green Valley Housing',
  'Islamabad',
  'DHA Phase 2',
  33.6844,
  73.0479,
  'Premium residential society in Islamabad'
FROM public.profiles
WHERE role = 'society' AND approval_status = 'approved'
LIMIT 1
ON CONFLICT DO NOTHING;

-- Sample plots (only if society exists)
INSERT INTO public.plots (society_id, plot_number, block, size_value, size_unit, category, price_pkr, status, svg_zone_id)
SELECT
  'a0000000-0000-0000-0000-000000000001'::uuid,
  plot_num,
  block,
  size_val,
  'marla'::plot_size_unit,
  'residential'::plot_category,
  price,
  'available'::plot_status,
  'zone-' || plot_num
FROM (VALUES
  ('101', 'A', 5.0, 3500000),
  ('102', 'A', 10.0, 6500000),
  ('201', 'B', 5.0, 3200000),
  ('202', 'B', 5.0, 3300000),
  ('301', 'C', 1.0, 15000000)
) AS t(plot_num, block, size_val, price)
WHERE EXISTS (SELECT 1 FROM public.societies WHERE id = 'a0000000-0000-0000-0000-000000000001'::uuid)
ON CONFLICT DO NOTHING;
