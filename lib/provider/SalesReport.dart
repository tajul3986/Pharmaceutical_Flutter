import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pharma_app/service/SalesReport.dart';
import '../model/order.dart';

class SalesItemDetail {
  final String name;
  final int quantity;
  final double price;
  final double total;
  final String date; // formatted
  final String time; // formatted

  SalesItemDetail({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    required this.date,
    required this.time,
  });
}

class SalesReportProvider extends ChangeNotifier {
  final SalesReportService _service;

  SalesReportProvider(this._service);

  bool _loading = false;
  bool get loading => _loading;

  double todaySales = 0;
  double monthlySales = 0;
  double yearlySales = 0;

  List<MapEntry<String, int>> topSellingMedicines = [];

  List<SalesItemDetail> detailedTodayList = [];
  List<SalesItemDetail> detailedMonthlyList = [];
  List<SalesItemDetail> detailedYearlyList = [];

  // Searchable lists
  List<SalesItemDetail> filteredMonthlyList = [];
  List<SalesItemDetail> filteredYearlyList = [];

  Future<void> load() async {
    try {
      _loading = true;
      notifyListeners();

      final orders = await _service.fetchOrders();

      // Flatten items, attach order date to each item (if missing)
      final allItems = <OrderItem>[];
      for (final o in orders) {
        final dateStr = o.date?.toIso8601String();
        for (final it in (o.items ?? [])) {
          allItems.add(OrderItem(
            id: it.id,
            name: it.name,
            quantity: it.quantity,
            price: it.price,
            orderDate: it.orderDate ?? dateStr,
          ));
        }
      }

      // Totals
      todaySales = _calculateSales(allItems, _DateRange.day);
      monthlySales = _calculateSales(allItems, _DateRange.month);
      yearlySales = _calculateSales(allItems, _DateRange.year);

      // Top selling (by quantity)
      final qtyMap = <String, int>{};
      for (final it in allItems) {
        final name = it.name ?? 'Unknown';
        final qty = it.quantity ?? 0;
        qtyMap[name] = (qtyMap[name] ?? 0) + qty;
      }
      topSellingMedicines = qtyMap.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if (topSellingMedicines.length > 5) {
        topSellingMedicines = topSellingMedicines.sublist(0, 5);
      }

      // Detailed lists
      detailedTodayList = _groupDetailed(allItems, _DateRange.day);
      detailedMonthlyList = _groupDetailed(allItems, _DateRange.month);
      filteredMonthlyList = List.from(detailedMonthlyList);
      detailedYearlyList = _groupDetailed(allItems, _DateRange.year);
      filteredYearlyList = List.from(detailedYearlyList);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void filterMonthly(String query) {
    final q = query.toLowerCase();
    filteredMonthlyList = detailedMonthlyList.where((e) {
      return e.name.toLowerCase().contains(q) || e.date.toLowerCase().contains(q);
    }).toList();
    notifyListeners();
  }

  void filterYearly(String query) {
    final q = query.toLowerCase();
    filteredYearlyList = detailedYearlyList.where((e) {
      return e.name.toLowerCase().contains(q) || e.date.toLowerCase().contains(q);
    }).toList();
    notifyListeners();
  }

  // ---- helpers ----

  double _calculateSales(List<OrderItem> items, _DateRange range) {
    final now = DateTime.now();
    return items
        .where((it) {
          if (it.orderDate == null) return false;
          final d = DateTime.tryParse(it.orderDate!);
          if (d == null) return false;
          return _inRange(d, now, range);
        })
        .fold<double>(0.0, (sum, it) {
          final p = it.price ?? 0;
          final q = it.quantity ?? 0;
          return sum + (p * q);
        });
  }

  List<SalesItemDetail> _groupDetailed(List<OrderItem> items, _DateRange range) {
    final now = DateTime.now();
    final dateFmt = DateFormat('dd/MM/yyyy');
    final timeFmt = DateFormat('hh:mm a');

    final filtered = items.where((it) {
      if (it.orderDate == null) return false;
      final d = DateTime.tryParse(it.orderDate!);
      if (d == null) return false;
      return _inRange(d, now, range);
    });

    return filtered.map((it) {
      final d = DateTime.tryParse(it.orderDate!)!;
      final price = (it.price ?? 0).toDouble();
      final qty = it.quantity ?? 0;
      return SalesItemDetail(
        name: it.name ?? 'Unknown',
        quantity: qty,
        price: price,
        total: price * qty,
        date: dateFmt.format(d),
        time: timeFmt.format(d),
      );
    }).toList();
  }

  bool _inRange(DateTime d, DateTime now, _DateRange range) {
    switch (range) {
      case _DateRange.day:
        return d.year == now.year && d.month == now.month && d.day == now.day;
      case _DateRange.month:
        return d.year == now.year && d.month == now.month;
      case _DateRange.year:
        return d.year == now.year;
    }
  }
}

enum _DateRange { day, month, year }
