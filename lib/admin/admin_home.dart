import 'package:flutter/material.dart';
import 'package:pharma_app/auth/login_page.dart';
import 'package:pharma_app/admin/Dashboard.dart';
import 'package:pharma_app/ui/MedicinePage.dart';
import 'package:pharma_app/ui/OrderManagement.dart';
import 'package:pharma_app/ui/SalesReport.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool isSidebarVisible = false; // default sidebar hidden, overlay হয়ে আসবে
  String selectedMenu = 'Dashboard';

  final menuItems = {
    'Dashboard': Icons.dashboard,
    'Manufacture': Icons.precision_manufacturing,
    'Category': Icons.category,
    'Sub Category': Icons.subdirectory_arrow_right,
    'Medicines': Icons.medical_services,
    'Order Management': Icons.assignment,
    'Inventory': Icons.inventory,
    'Sales Report': Icons.bar_chart,
  };

  final manufactureSubItems = {
    'Raw Materials': Icons.bubble_chart,
    'Raw Material Supplier': Icons.group,
    'Raw Material Import': Icons.import_export,
    'Manufacturing': Icons.build_circle,
  };

  Widget _getPageByMenu(String menu) {
    switch (menu) {
      case 'Dashboard':
        return const DashboardPage();
      case 'Medicines':
        return const MedicinePage();
      case 'Sales Report':
        return const SalesReportPage();
      case 'Order Management':
        return const OrderManagementPage();
      default:
        return Center(
          child: Text(
            '$menu Page Content',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }

  void _onMenuSelected(String menu) {
    setState(() {
      selectedMenu = menu;
      isSidebarVisible = false; // sidebar hide on selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Top Navbar
                Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menu icon to open sidebar
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            isSidebarVisible = true;
                          });
                        },
                      ),
                      Text(
                        selectedMenu,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48), // space to balance row
                    ],
                  ),
                ),
                // Page content fill rest
                Expanded(child: _getPageByMenu(selectedMenu)),
              ],
            ),

            // Sidebar overlay
            if (isSidebarVisible)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                width: 250,
                child: Material(
                  elevation: 16,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 10, 153, 5),
                        height: 64,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pharma',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSidebarVisible = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ...menuItems.entries.map((entry) {
                              if (entry.key == 'Manufacture') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: manufactureSubItems.entries.map((
                                    sub,
                                  ) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () {
                                        _onMenuSelected(sub.key);
                                      },
                                    );
                                  }).toList(),
                                );
                              } else {
                                return ListTile(
                                  leading: Icon(entry.value),
                                  title: Text(entry.key),
                                  selected: selectedMenu == entry.key,
                                  onTap: () {
                                    _onMenuSelected(entry.key);
                                  },
                                );
                              }
                            }),

                            const Divider(),

                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Dark translucent background when sidebar visible (for click outside to close)
            // if (isSidebarVisible)
            //   Positioned.fill(
            //     child: GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           isSidebarVisible = false;
            //         });
            //       },
            //       child: Container(
            //         color: Colors.black54,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
