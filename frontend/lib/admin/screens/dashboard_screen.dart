import 'package:flutter/material.dart';

import '../services/admin_service.dart';

import '../../shared/widgets/custom_sidebar.dart';
import '../../shared/widgets/top_navbar.dart';
import '../../shared/widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final service = AdminService(); // Admin service helper

  int users = 0;
  int properties = 0;
  int dealers = 0;
  int societies = 0;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);
      final results = await Future.wait([
        service.getUsersCount(),
        service.getPropertiesCount(),
        service.getDealersCount(),
        service.getSocietiesCount(),
      ]);

      users = results[0];
      properties = results[1];
      dealers = results[2];
      societies = results[3];
      errorMessage = null;
    } catch (e) {
      debugPrint("Error loading dashboard data: $e");
      errorMessage =
          "Failed to load dashboard data. Please check your connection.";
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const CustomSidebar(),

          Expanded(
            child: Column(
              children: [
                const TopNavbar(),
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              StatCard(title: "Users", value: users.toString()),
                              StatCard(
                                title: "Plots",
                                value: properties.toString(),
                              ),
                              StatCard(
                                title: "Dealers",
                                value: dealers.toString(),
                              ),
                              StatCard(
                                title: "Societies",
                                value: societies.toString(),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
