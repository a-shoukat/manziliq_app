const express = require('express');
const authRoutes = require('./modules/auth/auth.routes');
const societyRoutes = require('./modules/society/society.routes');
const plotsRoutes = require('./modules/plots/plots.routes');
const dealersRoutes = require('./modules/dealers/dealers.routes');
const lotsRoutes = require('./modules/lots/lots.routes');
const bookingsRoutes = require('./modules/bookings/bookings.routes');
const paymentsRoutes = require('./modules/payments/payments.routes');
const documentsRoutes = require('./modules/documents/documents.routes');
const notificationsRoutes = require('./modules/notifications/notifications.routes');

function createApp() {
  const app = express();
  const cors = require('cors');
  app.use(cors());
  app.use(express.json({ limit: '10mb' }));

  app.get('/health', (_req, res) => {
    res.json({ status: 'ok', service: 'ManzilIQ API', stack: 'Supabase' });
  });

  app.use('/api/auth', authRoutes);
  app.use('/api/societies', societyRoutes);
  app.use('/api/plots', plotsRoutes);
  app.use('/api/dealers', dealersRoutes);
  app.use('/api/lots', lotsRoutes);
  app.use('/api/bookings', bookingsRoutes);
  app.use('/api/payments', paymentsRoutes);
  app.use('/api/documents', documentsRoutes);
  app.use('/api/notifications', notificationsRoutes);

  app.use((_req, res) => res.status(404).json({ error: 'Route not found' }));

  return app;
}

module.exports = createApp;
