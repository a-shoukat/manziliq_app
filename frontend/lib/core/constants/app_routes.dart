class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const pendingApproval = '/pending-approval';

  // Admin
  static const adminDashboard = '/admin/dashboard';
  static const adminUserApproval = '/admin/user-approval';
  static const adminDisputes = '/admin/disputes';
  static const adminAnalytics = '/admin/analytics';

  // Society
  static const societyDashboard = '/society/dashboard';
  static const plotInventory = '/society/plots';
  static const plotUpload = '/society/plot-upload';
  static const dealerManagement = '/society/dealers';
  static const bookingApprovals = '/society/bookings';
  static const paymentConfig = '/society/payment-config';

  // Maps
  static const googleMap = '/maps/google';
  static const svgPlotMap = '/maps/svg';

  // Dealer
  static const dealerDashboard = '/dealer/dashboard';
  static const lotManagement = '/dealer/lots';
  static const dealPipeline = '/dealer/pipeline';
  static const commission = '/dealer/commission';

  // Customer
  static const customerDashboard = '/customer/dashboard';
  static const propertySearch = '/customer/search';
  static const plotDetail = '/customer/plot/:id';
  static const comparePlots = '/customer/compare';
  static const savedProperties = '/customer/saved';

  // Booking
  static const bookingForm = '/booking/form';
  static const bookingConfirmation = '/booking/confirmation';
  static const dealStages = '/booking/stages';
  static const siteVisit = '/booking/site-visit';

  // Payments
  static const payment = '/payments/pay';
  static const installmentPlan = '/payments/installments';
  static const paymentHistory = '/payments/history';
  static const receipt = '/payments/receipt';

  // Documents
  static const documentLocker = '/documents/locker';
  static const documentViewer = '/documents/viewer';

  // Notifications
  static const notificationInbox = '/notifications';
}
