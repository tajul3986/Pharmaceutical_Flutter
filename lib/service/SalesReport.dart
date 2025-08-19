import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/order.dart'; // <-- your Order/OrderItem model file

class SalesReportService {
  static const String _orderUrl = 'http://localhost:8080/pharma/orders';

  Future<List<Order>> fetchOrders() async {
    final res = await http.get(Uri.parse(_orderUrl));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data is List) {
        return data.map((e) => Order.fromJson(e as Map<String, dynamic>)).toList();
      }
      // Sometimes backend returns { content:[...] } or something similar
      if (data is Map && data['content'] is List) {
        return (data['content'] as List)
            .map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load orders: ${res.statusCode}');
    }
  }
}
