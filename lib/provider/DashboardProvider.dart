import 'package:flutter/material.dart';
import 'package:pharma_app/model/Order.dart';
import 'package:pharma_app/service/DashboardService.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService _service = DashboardService();

  int totalMedicines = 0;
  int stockAlerts = 0;
  num monthlySales = 0;
  int newOrders = 0;

  List<Order> recentOrders = [];
  //Map<String, int> barChartData = {};
  Map<String, num> barChartData = {};
  Map<String, int> pieChartData = {};

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadDashboardData() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final medicines = await _service.fetchMedicines();
      final orders = await _service.fetchOrders();

      totalMedicines = medicines.length;
      stockAlerts = medicines.where((m) => (m.stock) < 5).length;

      final now = DateTime.now();
      final currentMonthOrders = orders.where((order) =>
          order.date?.month == now.month &&
          order.date?.year == now.year).toList();

      final thisMonthItems = currentMonthOrders
          .expand((order) => order.items ?? [])
          .toList();

      monthlySales = thisMonthItems.fold(
          0, (sum, item) => sum + (item.quantity ?? 0));

     //monthlySales = thisMonthItems.fold(0, (sum, item) => sum + (item.quantity ?? 0)) as int;



      newOrders = currentMonthOrders.length;

      recentOrders = orders
          .expand((order) => order.items!.map((item) => Order(
                id: order.id,
                orderCode: order.orderCode,
                date: order.date,
                customerName: item.name,
                items: [item],
              )))
          .toList()
        ..sort((a, b) => b.date!.compareTo(a.date!))
        ..take(5);

      // Bar chart: medicine name -> qty sold
      barChartData = {};
      for (var item in thisMonthItems) {
        if (item.name != null) {
          barChartData[item.name!] =
              (barChartData[item.name!] ?? 0) + (item.quantity ?? 0);
        }
      }

      // Pie chart: medicine name -> stock
      pieChartData = {
        for (var m in medicines) ?m.name: m.stock
      };
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
