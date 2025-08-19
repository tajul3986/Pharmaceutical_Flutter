// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class InvoicePage extends StatelessWidget {
//   final List<Map<String, dynamic>> cartItems;
//   final Map<String, dynamic> deliveryInfo;
//   final Map<String, dynamic> paymentInfo;

//   const InvoicePage({
//     super.key,
//     required this.cartItems,
//     required this.deliveryInfo,
//     required this.paymentInfo,
//   });

//   double get totalAmount {
//     double sum = 0;
//     for (var item in cartItems) {
//       sum += (item['price'] as num) * (item['quantity'] as num);
//     }
//     return sum;
//   }

//   Future<void> _generatePdf(BuildContext context) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context ctx) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text("🧾 Invoice",
//                   style: pw.TextStyle(
//                       fontSize: 24, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 20),

//               // Delivery Information
//               pw.Text("🚚 Delivery Information:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Text("Name: ${deliveryInfo['name']}"),
//               pw.Text("Address: ${deliveryInfo['address']}"),
//               pw.Text("Phone: ${deliveryInfo['phone']}"),

//               pw.SizedBox(height: 20),

//               // Payment Details
//               pw.Text("💳 Payment Details:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Text("Method: ${paymentInfo['method']}"),
//               if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
//                 pw.Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
//               if (paymentInfo['transactionId'] != null &&
//                   paymentInfo['transactionId'].toString().isNotEmpty)
//                 pw.Text("Transaction ID: ${paymentInfo['transactionId']}"),
//               if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
//                 pw.Text("Cardholder Name: ${paymentInfo['cardName']}"),
//               if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
//                 pw.Text("Card Number: ${paymentInfo['cardNumber']}"),

//               pw.SizedBox(height: 20),

//               // Ordered Items Table
//               pw.Text("📦 Ordered Items:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Table.fromTextArray(
//                 headers: ["Medicine", "Qty", "Price"],
//                 data: cartItems
//                     .map((item) => [
//                           item['name'],
//                           item['quantity'].toString(),
//                           "৳${item['price']}"
//                         ])
//                     .toList(),
//               ),

//               pw.SizedBox(height: 20),

//               pw.Text("Total: ৳${totalAmount.toStringAsFixed(2)}",
//                   style: pw.TextStyle(
//                       fontSize: 20, fontWeight: pw.FontWeight.bold)),
//             ],
//           );
//         },
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (format) async => pdf.save(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice"),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.picture_as_pdf),
//             onPressed: () => _generatePdf(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             const Text("🚚 Delivery Information",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text("Name: ${deliveryInfo['customerName']}"),
//             Text("Address: ${deliveryInfo['address']}"),
//             Text("Phone: ${deliveryInfo['phone']}"),
//             const Divider(),
//             const SizedBox(height: 10),

//             const Text("💳 Payment Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text("Method: ${paymentInfo['method']}"),
//             if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
//               Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
//             if (paymentInfo['transactionId'] != null &&
//                 paymentInfo['transactionId'].toString().isNotEmpty)
//               Text("Transaction ID: ${paymentInfo['transactionId']}"),
//             if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
//               Text("Cardholder Name: ${paymentInfo['cardName']}"),
//             if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
//               Text("Card Number: ${paymentInfo['cardNumber']}"),
//             const Divider(),
//             const SizedBox(height: 10),

//             const Text("📦 Ordered Items",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Table(
//               border: TableBorder.all(color: Colors.grey),
//               children: [
//                 const TableRow(
//                   decoration: BoxDecoration(color: Colors.teal),
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Medicine",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Qty",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Price",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ],
//                 ),
//                 ...cartItems.map((item) => TableRow(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['name']),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['quantity'].toString()),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("৳${item['price']}"),
//                         ),
//                       ],
//                     )),
//               ],
//             ),

//             const SizedBox(height: 10),
//             Text(
//               "Total: ৳${totalAmount.toStringAsFixed(2)}",
//               style: const TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => _generatePdf(context),
//               icon: const Icon(Icons.download, color: Colors.white),
//               label: const Text(
//                 "Download PDF",
//                 style: TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//with delivery fee, subtotal, vat

// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class InvoicePage extends StatelessWidget {
//   final List<Map<String, dynamic>> cartItems;
//   final Map<String, dynamic> deliveryInfo;
//   final Map<String, dynamic> paymentInfo;

//   // Add deliveryFee here (default 0 if not provided)
//   final double deliveryFee;

//   const InvoicePage({
//     super.key,
//     required this.cartItems,
//     required this.deliveryInfo,
//     required this.paymentInfo,
//     this.deliveryFee = 0.0, required double subtotal, required double vat,
//   });

//   double get subtotal {
//     double sum = 0;
//     for (var item in cartItems) {
//       sum += (item['price'] as num) * (item['quantity'] as num);
//     }
//     return sum;
//   }

//   double get vat => subtotal * 0.15;

//   double get totalAmount => subtotal + vat + deliveryFee;

//   Future<void> _generatePdf(BuildContext context) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context ctx) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text("🧾 Invoice",
//                   style: pw.TextStyle(
//                       fontSize: 24, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 20),

//               // Delivery Information
//               pw.Text("🚚 Delivery Information:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Text("Name: ${deliveryInfo['name']}"),
//               pw.Text("Address: ${deliveryInfo['address']}"),
//               pw.Text("Phone: ${deliveryInfo['phone']}"),

//               pw.SizedBox(height: 20),

//               // Payment Details
//               pw.Text("💳 Payment Details:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Text("Method: ${paymentInfo['method']}"),
//               if (paymentInfo['mobileType'] != null &&
//                   paymentInfo['mobileType'].toString().isNotEmpty)
//                 pw.Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
//               if (paymentInfo['transactionId'] != null &&
//                   paymentInfo['transactionId'].toString().isNotEmpty)
//                 pw.Text("Transaction ID: ${paymentInfo['transactionId']}"),
//               if (paymentInfo['cardName'] != null &&
//                   paymentInfo['cardName'].toString().isNotEmpty)
//                 pw.Text("Cardholder Name: ${paymentInfo['cardName']}"),
//               if (paymentInfo['cardNumber'] != null &&
//                   paymentInfo['cardNumber'].toString().isNotEmpty)
//                 pw.Text("Card Number: ${paymentInfo['cardNumber']}"),

//               pw.SizedBox(height: 20),

//               // Ordered Items Table
//               pw.Text("📦 Ordered Items:",
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.Table.fromTextArray(
//                 headers: ["Medicine", "Qty", "Price"],
//                 data: cartItems
//                     .map((item) => [
//                           item['name'],
//                           item['quantity'].toString(),
//                           "৳${item['price']}"
//                         ])
//                     .toList(),
//               ),

//               pw.SizedBox(height: 20),

//               // Totals Section
//               pw.Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
//               pw.Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
//               pw.Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
//               pw.Text("Total: ৳${totalAmount.toStringAsFixed(2)}",
//                   style: pw.TextStyle(
//                       fontSize: 20, fontWeight: pw.FontWeight.bold)),
//             ],
//           );
//         },
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (format) async => pdf.save(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice"),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.picture_as_pdf),
//             onPressed: () => _generatePdf(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             const Text("🚚 Delivery Information",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text("Name: ${deliveryInfo['customerName']}"),
//             Text("Address: ${deliveryInfo['address']}"),
//             Text("Phone: ${deliveryInfo['phone']}"),
//             const Divider(),
//             const SizedBox(height: 10),

//             const Text("💳 Payment Details",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text("Method: ${paymentInfo['method']}"),
//             if (paymentInfo['mobileType'] != null &&
//                 paymentInfo['mobileType'].toString().isNotEmpty)
//               Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
//             if (paymentInfo['transactionId'] != null &&
//                 paymentInfo['transactionId'].toString().isNotEmpty)
//               Text("Transaction ID: ${paymentInfo['transactionId']}"),
//             if (paymentInfo['cardName'] != null &&
//                 paymentInfo['cardName'].toString().isNotEmpty)
//               Text("Cardholder Name: ${paymentInfo['cardName']}"),
//             if (paymentInfo['cardNumber'] != null &&
//                 paymentInfo['cardNumber'].toString().isNotEmpty)
//               Text("Card Number: ${paymentInfo['cardNumber']}"),
//             const Divider(),
//             const SizedBox(height: 10),

//             const Text("📦 Ordered Items",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Table(
//               border: TableBorder.all(color: Colors.grey),
//               children: [
//                 const TableRow(
//                   decoration: BoxDecoration(color: Colors.teal),
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Medicine",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Qty",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Price",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ],
//                 ),
//                 ...cartItems.map((item) => TableRow(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['name']),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(item['quantity'].toString()),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("৳${item['price']}"),
//                         ),
//                       ],
//                     )),
//               ],
//             ),

//             const SizedBox(height: 10),
//             Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
//             Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
//             Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
//             Text(
//               "Total: ৳${totalAmount.toStringAsFixed(2)}",
//               style: const TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => _generatePdf(context),
//               icon: const Icon(Icons.download, color: Colors.white),
//               label: const Text(
//                 "Download PDF",
//                 style: TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//with date and time

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class InvoicePage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;
  final Map<String, dynamic> paymentInfo;
  final double deliveryFee;
  final double subtotal;
  final double vat;
  final DateTime orderDate;
  final String orderCode; 

  const InvoicePage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
    required this.paymentInfo,
    required this.deliveryFee,
    required this.subtotal,
    required this.vat,
    required this.orderDate, 
    required this.orderCode,
    
  });

  double get totalAmount => subtotal + vat + deliveryFee;

  String get formattedDate {
    return DateFormat('dd MMM yyyy, hh:mm a').format(orderDate);
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("🧾 Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("🗓️ Date & Time: $formattedDate", style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              pw.Text("Order Code: $orderCode", style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              // Delivery Info
              pw.Text("🚚 Delivery Information:", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Name: ${deliveryInfo['customerName']}"),
              pw.Text("Address: ${deliveryInfo['address']}"),
              pw.Text("Phone: ${deliveryInfo['phone']}"),
              pw.SizedBox(height: 20),

              // Payment Info
              pw.Text("💳 Payment Details:", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Method: ${paymentInfo['method']}"),
              if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
                pw.Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
              if (paymentInfo['transactionId'] != null && paymentInfo['transactionId'].toString().isNotEmpty)
                pw.Text("Transaction ID: ${paymentInfo['transactionId']}"),
              if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
                pw.Text("Cardholder Name: ${paymentInfo['cardName']}"),
              if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
                pw.Text("Card Number: ${paymentInfo['cardNumber']}"),
              pw.SizedBox(height: 20),

              // Ordered Items
              pw.Text("📦 Ordered Items:", style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(
                headers: ["Medicine", "Qty", "Price"],
                data: cartItems.map((item) => [
                      item['name'],
                      item['quantity'].toString(),
                      "৳${item['price']}",
                    ]).toList(),
              ),
              pw.SizedBox(height: 20),

              // Totals
              pw.Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
              pw.Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
              pw.Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
              pw.Text("Total: ৳${totalAmount.toStringAsFixed(2)}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("🗓️ Order Date & Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(formattedDate),
            const SizedBox(height: 20),

            //const Text(" Order Code : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(" Order Code : $orderCode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),

            const Text("🚚 Delivery Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Name: ${deliveryInfo['customerName']}"),
            const SizedBox(height: 5),
            Text("Address: ${deliveryInfo['address']}"),
            const SizedBox(height: 5),
            Text("Phone: ${deliveryInfo['phone']}"),
            const Divider(),

            const SizedBox(height: 10),
            const Text("💳 Payment Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Method: ${paymentInfo['method']}"),
            const SizedBox(height: 5),
            if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
              Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
              const SizedBox(height: 5),
            if (paymentInfo['transactionId'] != null && paymentInfo['transactionId'].toString().isNotEmpty)
              Text("Transaction ID: ${paymentInfo['transactionId']}"),
            if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
              Text("Cardholder Name: ${paymentInfo['cardName']}"),
              const SizedBox(height: 5),
            if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
              Text("Card Number: ${paymentInfo['cardNumber']}"),
            const Divider(),

            const SizedBox(height: 10),
            const Text("📦 Ordered Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.teal),
                  children: [
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Medicine", style: TextStyle(color: Colors.white))),
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Qty", style: TextStyle(color: Colors.white))),
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Price", style: TextStyle(color: Colors.white))),
                  ],
                ),
                ...cartItems.map((item) => TableRow(children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text(item['name'])),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text(item['quantity'].toString())),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text("৳${item['price']}")),
                    ])),
              ],
            ),

            const SizedBox(height: 10),
            Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("Total: ৳${totalAmount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => _generatePdf(context),
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text("Download PDF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
