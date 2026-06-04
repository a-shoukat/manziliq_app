import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'admin/screens/analytics_screen.dart';
import 'admin/screens/dashboard_screen.dart';
import 'admin/screens/disputes_screen.dart';
import 'admin/screens/user_approval_screen.dart';
import 'auth/screens/login_screen.dart';
import 'auth/screens/otp_screen.dart';
import 'auth/screens/pending_approval_screen.dart';
import 'auth/screens/register_screen.dart';
import 'auth/screens/splash_screen.dart';
import 'booking/screens/booking_confirmation_screen.dart';
import 'booking/screens/booking_form_screen.dart';
import 'booking/screens/deal_stages_screen.dart';
import 'booking/screens/site_visit_screen.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'customer/screens/compare_plots_screen.dart';
import 'customer/screens/customer_dashboard.dart';
import 'customer/screens/plot_detail_screen.dart';
import 'customer/screens/property_search_screen.dart';
import 'customer/screens/saved_properties_screen.dart';
import 'dealer/screens/commission_screen.dart';
import 'dealer/screens/deal_pipeline_screen.dart';
import 'dealer/screens/dealer_dashboard.dart';
import 'dealer/screens/lot_management_screen.dart';
import 'documents/screens/document_locker_screen.dart';
import 'documents/screens/document_viewer_screen.dart';
import 'maps/screens/google_map_screen.dart';
import 'maps/screens/svg_plot_map_screen.dart';
import 'models/user_model.dart';
import 'notifications/screens/notification_inbox_screen.dart';
import 'payments/screens/installment_plan_screen.dart';
import 'payments/screens/payment_history_screen.dart';
import 'payments/screens/payment_screen.dart';
import 'payments/screens/receipt_screen.dart';
import 'providers/auth_provider.dart';
import 'society/screens/booking_approvals_screen.dart';
import 'society/screens/dealer_management_screen.dart';
import 'society/screens/payment_config_screen.dart';
import 'society/screens/plot_inventory_screen.dart';
import 'society/screens/plot_upload_screen.dart';
import 'society/screens/society_dashboard.dart';

class ManzilApp extends StatelessWidget {
  const ManzilApp({super.key});

  static GoRouter _router(AuthProvider auth) {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: auth,
      redirect: (context, state) {
        final loc = state.matchedLocation;
        final isAuthFlow = {
          AppRoutes.splash,
          AppRoutes.login,
          AppRoutes.register,
          AppRoutes.otp,
        }.contains(loc);

        if (auth.loading && loc != AppRoutes.splash) {
          return AppRoutes.splash;
        }

        if (!auth.isLoggedIn) {
          if (loc == AppRoutes.pendingApproval) return AppRoutes.login;
          if (!isAuthFlow) return AppRoutes.login;
          return null;
        }

        if (!auth.isApproved) {
          if (loc != AppRoutes.pendingApproval) return AppRoutes.pendingApproval;
          return null;
        }

        if (!auth.user!.emailVerified && loc != AppRoutes.otp) {
          return AppRoutes.otp;
        }

        if (isAuthFlow || loc == AppRoutes.pendingApproval) {
          return _homeForRole(auth.user!.role);
        }

        return _guardRoleRoute(auth.user!.role, loc);
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (_, __) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoutes.otp,
          builder: (_, __) => const OtpScreen(),
        ),
        GoRoute(
          path: AppRoutes.pendingApproval,
          builder: (_, __) => const PendingApprovalScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminDashboard,
          builder: (_, __) => const DashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminUserApproval,
          builder: (_, __) => const UserApprovalScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminDisputes,
          builder: (_, __) => const DisputesScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminAnalytics,
          builder: (_, __) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: AppRoutes.societyDashboard,
          builder: (_, __) => const SocietyDashboard(),
        ),
        GoRoute(
          path: AppRoutes.plotInventory,
          builder: (_, __) => const PlotInventoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.plotUpload,
          builder: (_, __) => const PlotUploadScreen(),
        ),
        GoRoute(
          path: AppRoutes.dealerManagement,
          builder: (_, __) => const DealerManagementScreen(),
        ),
        GoRoute(
          path: AppRoutes.bookingApprovals,
          builder: (_, __) => const BookingApprovalsScreen(),
        ),
        GoRoute(
          path: AppRoutes.paymentConfig,
          builder: (_, __) => const PaymentConfigScreen(),
        ),
        GoRoute(
          path: AppRoutes.googleMap,
          builder: (_, __) => const GoogleMapScreen(),
        ),
        GoRoute(
          path: AppRoutes.svgPlotMap,
          builder: (_, __) => const SvgPlotMapScreen(),
        ),
        GoRoute(
          path: AppRoutes.dealerDashboard,
          builder: (_, __) => const DealerDashboard(),
        ),
        GoRoute(
          path: AppRoutes.lotManagement,
          builder: (_, __) => const LotManagementScreen(),
        ),
        GoRoute(
          path: AppRoutes.dealPipeline,
          builder: (_, __) => const DealPipelineScreen(),
        ),
        GoRoute(
          path: AppRoutes.commission,
          builder: (_, __) => const CommissionScreen(),
        ),
        GoRoute(
          path: AppRoutes.customerDashboard,
          builder: (_, __) => const CustomerDashboard(),
        ),
        GoRoute(
          path: AppRoutes.propertySearch,
          builder: (_, __) => const PropertySearchScreen(),
        ),
        GoRoute(
          path: AppRoutes.plotDetail,
          builder: (_, state) => PlotDetailScreen(
            plotId: state.pathParameters['id'] ?? '',
          ),
        ),
        GoRoute(
          path: AppRoutes.comparePlots,
          builder: (_, __) => const ComparePlotsScreen(),
        ),
        GoRoute(
          path: AppRoutes.savedProperties,
          builder: (_, __) => const SavedPropertiesScreen(),
        ),
        GoRoute(
          path: AppRoutes.bookingForm,
          builder: (_, __) => const BookingFormScreen(),
        ),
        GoRoute(
          path: AppRoutes.bookingConfirmation,
          builder: (_, __) => const BookingConfirmationScreen(),
        ),
        GoRoute(
          path: AppRoutes.dealStages,
          builder: (_, __) => const DealStagesScreen(),
        ),
        GoRoute(
          path: AppRoutes.siteVisit,
          builder: (_, __) => const SiteVisitScreen(),
        ),
        GoRoute(
          path: AppRoutes.payment,
          builder: (_, __) => const PaymentScreen(),
        ),
        GoRoute(
          path: AppRoutes.installmentPlan,
          builder: (_, __) => const InstallmentPlanScreen(),
        ),
        GoRoute(
          path: AppRoutes.paymentHistory,
          builder: (_, __) => const PaymentHistoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.receipt,
          builder: (_, __) => const ReceiptScreen(),
        ),
        GoRoute(
          path: AppRoutes.documentLocker,
          builder: (_, __) => const DocumentLockerScreen(),
        ),
        GoRoute(
          path: AppRoutes.documentViewer,
          builder: (_, __) => const DocumentViewerScreen(),
        ),
        GoRoute(
          path: AppRoutes.notificationInbox,
          builder: (_, __) => const NotificationInboxScreen(),
        ),
      ],
    );
  }

  static String _homeForRole(UserRole role) => switch (role) {
        UserRole.admin => AppRoutes.adminDashboard,
        UserRole.society => AppRoutes.societyDashboard,
        UserRole.dealer => AppRoutes.dealerDashboard,
        UserRole.customer => AppRoutes.customerDashboard,
      };

  static String? _guardRoleRoute(UserRole role, String loc) {
    final adminRoutes = [
      AppRoutes.adminDashboard,
      AppRoutes.adminUserApproval,
      AppRoutes.adminDisputes,
      AppRoutes.adminAnalytics,
    ];
    final societyRoutes = [
      AppRoutes.societyDashboard,
      AppRoutes.plotInventory,
      AppRoutes.plotUpload,
      AppRoutes.dealerManagement,
      AppRoutes.bookingApprovals,
      AppRoutes.paymentConfig,
      AppRoutes.googleMap,
      AppRoutes.svgPlotMap,
    ];
    final dealerRoutes = [
      AppRoutes.dealerDashboard,
      AppRoutes.lotManagement,
      AppRoutes.dealPipeline,
      AppRoutes.commission,
    ];

    final shared = [
      AppRoutes.bookingForm,
      AppRoutes.bookingConfirmation,
      AppRoutes.dealStages,
      AppRoutes.siteVisit,
      AppRoutes.payment,
      AppRoutes.installmentPlan,
      AppRoutes.paymentHistory,
      AppRoutes.receipt,
      AppRoutes.documentLocker,
      AppRoutes.documentViewer,
      AppRoutes.notificationInbox,
      AppRoutes.googleMap,
      AppRoutes.svgPlotMap,
    ];

    bool allowed;
    switch (role) {
      case UserRole.admin:
        allowed = adminRoutes.contains(loc) || shared.contains(loc);
      case UserRole.society:
        allowed = societyRoutes.contains(loc) || shared.contains(loc);
      case UserRole.dealer:
        allowed =
            dealerRoutes.contains(loc) || shared.contains(loc);
      case UserRole.customer:
        allowed = loc.startsWith('/customer') ||
            shared.contains(loc) ||
            loc.startsWith('/booking') ||
            loc.startsWith('/payments') ||
            loc.startsWith('/documents') ||
            loc.startsWith('/notifications') ||
            loc.startsWith('/maps');
    }

    if (!allowed) return _homeForRole(role);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return MaterialApp.router(
      title: 'ManzilIQ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router(auth),
    );
  }
}

GoRouter createAppRouter(AuthProvider auth) => ManzilApp._router(auth);
