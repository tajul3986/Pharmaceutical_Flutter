import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma_app/model/Medicine.dart';
import 'package:pharma_app/model/Order.dart';

class DashboardService {
  final String productUrl = 'http://localhost:8080/pharma/product';
  final String orderUrl = 'http://localhost:8080/pharma/orders';

  Future<List<Medicine>> fetchMedicines() async {
    final response = await http.get(Uri.parse(productUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Medicine.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load medicines');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(orderUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
