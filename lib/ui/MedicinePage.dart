import 'package:flutter/material.dart';
import 'package:pharma_app/model/Medicine.dart';
import 'package:pharma_app/provider/MedicineProvider.dart';
import 'package:provider/provider.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicine();
  }

  void _showMedicineDialog({Medicine? medicine}) {
    final formKey = GlobalKey<FormState>();
    final codeController = TextEditingController(text: medicine?.productCode ?? '');
    final nameController = TextEditingController(text: medicine?.name ?? '');
    final priceController = TextEditingController(text: medicine?.price?.toString() ?? '');
    final categoryController = TextEditingController(text: medicine?.category ?? '');
    final subcategoryController = TextEditingController(text: medicine?.subcategory ?? '');
    final stockController = TextEditingController(text: medicine?.stock.toString() ?? '');
    final descController = TextEditingController(text: medicine?.description ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(medicine == null ? "Add Medicine" : "Edit Medicine"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(labelText: "Medicine Code"),
                    validator: (val) => val!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Medicine Name"),
                    validator: (val) => val!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: "Category"),
                    validator: (val) => val!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: subcategoryController,
                    decoration: const InputDecoration(labelText: "SubCategory"),
                    validator: (val) => val!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: stockController,
                    decoration: const InputDecoration(labelText: "Stock"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: "Description"),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final newMedicine = Medicine(
                    id: medicine?.id,
                    productCode: codeController.text,
                    name: nameController.text,
                    price: double.tryParse(priceController.text) ?? 0,
                    stock: int.tryParse(stockController.text) ?? 0,
                    description: descController.text,
                    category: medicine?.category ?? "General",
                    subcategory: medicine?.subcategory ?? "None",
                    image: medicine?.image,
                  );

                  final provider = Provider.of<MedicineProvider>(context, listen: false);
                  if (medicine == null) {
                    provider.addMedicine(newMedicine);
                  } else {
                    provider.updateMedicine(newMedicine);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(medicine == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicineProvider>(context);
    final medicines = provider.medicine;
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1; // default mobile
    if (width >= 1200) {
      crossAxisCount = 4; // desktop
    } else if (width >= 800) {
      crossAxisCount = 2; // tablet
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Management"),
        automaticallyImplyLeading: false, // ← back arrow hide করবে
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showMedicineDialog(),
          ),
        ],
      ),
      body: medicines.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  final imageUrl = medicine.image != null
                      ? "http://localhost:8080/image/${medicine.image}"
                      : null;

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_medicine.png',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/default_medicine.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(medicine.name ?? ""),
                      subtitle: Text("Price: ${medicine.price} | Stock: ${medicine.stock}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showMedicineDialog(medicine: medicine),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => provider.deleteMedicine(medicine.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

