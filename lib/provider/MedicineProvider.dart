import 'package:flutter/foundation.dart';
import 'package:pharma_app/model/Medicine.dart';
import 'package:pharma_app/service/MedicineService.dart';

class MedicineProvider with ChangeNotifier {
  final MedicineService _medicineService = MedicineService();
  List<Medicine> _medicine = [];

  List<Medicine> get medicine => _medicine;

  Future<void> fetchMedicine() async {
    try {
      _medicine = await _medicineService.getMedicines();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching medicine: $e');
      }
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    try {
      final newMedicine = await _medicineService.createMedicine(medicine);
      _medicine.add(newMedicine);
      notifyListeners();
    } catch (e) {
      print('Error adding medicine: $e');
    }
  }

  Future<void> updateMedicine(Medicine medicine) async {
    try {
      final updateMedicine = await _medicineService.updateMedicine(medicine);
      final index = _medicine.indexWhere((t) => t.id == updateMedicine.id);
      if (index != -1) {
        _medicine[index] = updateMedicine;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating medicine: $e');
    }
  }

  Future<void> deleteMedicine(int id) async {
    try {
      await _medicineService.deleteMedicine(id);
      _medicine.removeWhere((medicine) => medicine.id == id);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting medicine: $e');
      }
    }
  }
}
