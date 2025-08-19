// import 'package:flutter/material.dart';
// import 'package:pharma_app/ui/Payment.dart';

// class CheckoutPage extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;

//   const CheckoutPage({super.key, required this.cartItems});

//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout"),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         elevation: 4,
//       ),
//       backgroundColor: const Color(0xFFF2F2F2),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 6,
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Delivery Information",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
//                   ),
//                   const SizedBox(height: 20),

//                   // Name Field
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: "Full Name",
//                       prefixIcon: const Icon(Icons.person, color: Colors.teal),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.teal, width: 2),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (value) => value!.isEmpty ? "Please enter your name" : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Phone Field
//                   TextFormField(
//                     controller: phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: "Phone Number",
//                       prefixIcon: const Icon(Icons.phone, color: Colors.teal),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.teal, width: 2),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (value) => value!.isEmpty ? "Please enter phone number" : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Address Field
//                   TextFormField(
//                     controller: addressController,
//                     maxLines: 3,
//                     decoration: InputDecoration(
//                       labelText: "Address",
//                       prefixIcon: const Icon(Icons.location_on, color: Colors.teal),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.teal, width: 2),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (value) => value!.isEmpty ? "Please enter address" : null,
//                   ),

//                   const SizedBox(height: 30),

//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           final deliveryInfo = {
//                             "name": nameController.text,
//                             "phone": phoneController.text,
//                             "address": addressController.text,
//                           };

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PaymentPage(
//                                 cartItems: widget.cartItems,
//                                 deliveryInfo: deliveryInfo,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                         backgroundColor: Colors.teal,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                         elevation: 4,
//                         textStyle: const TextStyle(fontSize: 18),
//                       ),
//                       child: const Text("Proceed To Payment"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//with backend order model

import 'package:flutter/material.dart';
import 'package:pharma_app/ui/OrderSummary.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery Information",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: const Icon(Icons.person, color: Colors.teal),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                  ),
                  const SizedBox(height: 16),

                  // Phone Field
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone, color: Colors.teal),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? "Please enter phone number" : null,
                  ),
                  const SizedBox(height: 16),

                  // Address Field
                  TextFormField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Address",
                      prefixIcon: const Icon(Icons.location_on, color: Colors.teal),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? "Please enter address" : null,
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final deliveryInfo = {
                            "customerName": nameController.text, // updated key for backend
                            "phone": phoneController.text,
                            "address": addressController.text,
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderSummaryDialog(
                                cartItems: widget.cartItems,
                                deliveryInfo: deliveryInfo,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 4,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Proceed To Payment"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
