import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma_app/model/Medicine.dart';

class MedicineService {
  final String baseUrl = 'http://localhost:8080/pharma/product';

  Future<List<Medicine>> getMedicines() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((medicine) => Medicine.fromJson(medicine)).toList();
    } else {
      throw Exception('Failed to load medicine');
    }
  }

  Future<Medicine> createMedicine(Medicine medicine) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(medicine.toJson()),
    );
    if (response.statusCode == 200) {
      return Medicine.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create medicine');
    }
  }

  Future<Medicine> updateMedicine(Medicine medicine) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${medicine.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(medicine.toJson()),
    );
    if (response.statusCode == 200) {
      return Medicine.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
    
  }

  Future<void> deleteMedicine(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete medicine');
    }
  }
}