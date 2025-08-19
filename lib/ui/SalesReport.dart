// import 'package:flutter/material.dart';
// import 'package:pharma_app/provider/SalesReport.dart';
// import 'package:provider/provider.dart';

// class SalesReportPage extends StatefulWidget {
//   const SalesReportPage({super.key});

//   @override
//   State<SalesReportPage> createState() => _SalesReportPageState();
// }

// class _SalesReportPageState extends State<SalesReportPage> {
//   final _monthlyCtrl = TextEditingController();
//   final _yearlyCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         context.read<SalesReportProvider>().load());
//   }

//   @override
//   void dispose() {
//     _monthlyCtrl.dispose();
//     _yearlyCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<SalesReportProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('📊 Sales Summary Report')),
//       body: prov.loading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Summary cards
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: [
//                       _summaryCard('Today\'s Sales', prov.todaySales),
//                       _summaryCard('Monthly Sales', prov.monthlySales),
//                       _summaryCard('Yearly Sales', prov.yearlySales),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Top Selling
//                   _sectionCard(
//                     title: '🏆 Top Selling Medicines',
//                     child: _topSellingList(prov),
//                   ),
//                   const SizedBox(height: 16),

//                   // Today details
//                   _sectionCard(
//                     title: '📅 Today\'s Medicine Sales (Details)',
//                     child: _detailsTable(prov.detailedTodayList),
//                   ),
//                   const SizedBox(height: 16),

//                   // Monthly details with search
//                   _sectionCard(
//                     title: '🗓️ Monthly Medicine Sales (Details)',
//                     headerAction: SizedBox(
//                       width: 280,
//                       child: TextField(
//                         controller: _monthlyCtrl,
//                         decoration: const InputDecoration(
//                           hintText: 'Search by name or date',
//                           prefixIcon: Icon(Icons.search),
//                           border: OutlineInputBorder(),
//                           isDense: true,
//                         ),
//                         onChanged: prov.filterMonthly,
//                       ),
//                     ),
//                     child: _detailsTable(prov.filteredMonthlyList),
//                   ),
//                   const SizedBox(height: 16),

//                   // Yearly details with search
//                   _sectionCard(
//                     title: '📆 Yearly Medicine Sales (Details)',
//                     headerAction: SizedBox(
//                       width: 280,
//                       child: TextField(
//                         controller: _yearlyCtrl,
//                         decoration: const InputDecoration(
//                           hintText: 'Search by name or date',
//                           prefixIcon: Icon(Icons.search),
//                           border: OutlineInputBorder(),
//                           isDense: true,
//                         ),
//                         onChanged: prov.filterYearly,
//                       ),
//                     ),
//                     child: _detailsTable(prov.filteredYearlyList),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _summaryCard(String title, double amount) {
//     return Container(
//       width: 260,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 8),
//           Text('৳ ${amount.toStringAsFixed(2)}',
//               style:
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _sectionCard({
//     required String title,
//     required Widget child,
//     Widget? headerAction,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//         boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(12)),
//               color: Colors.blue.shade50,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(title,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w700, fontSize: 16)),
//                 ),
//                 if (headerAction != null) headerAction,
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: child,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _topSellingList(SalesReportProvider prov) {
//     if (prov.topSellingMedicines.isEmpty) {
//       return const Text('No data');
//     }
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: prov.topSellingMedicines.length,
//       separatorBuilder: (_, __) => const Divider(height: 1),
//       itemBuilder: (_, i) {
//         final e = prov.topSellingMedicines[i];
//         return ListTile(
//           dense: true,
//           title: Text(e.key),
//           trailing: Text('Qty: ${e.value}'),
//         );
//       },
//     );
//   }

//   Widget _detailsTable(List<SalesItemDetail> items) {
//     if (items.isEmpty) return const Text('No data');

//     // Make it horizontally scrollable like HTML tables
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: const [
//           DataColumn(label: Text('Medicine')),
//           DataColumn(label: Text('Quantity')),
//           DataColumn(label: Text('Price (৳)')),
//           DataColumn(label: Text('Total (৳)')),
//           DataColumn(label: Text('Date')),
//           DataColumn(label: Text('Time')),
//         ],
//         rows: items
//             .map(
//               (e) => DataRow(cells: [
//                 DataCell(Text(e.name)),
//                 DataCell(Text(e.quantity.toString())),
//                 DataCell(Text(e.price.toStringAsFixed(2))),
//                 DataCell(Text(e.total.toStringAsFixed(2))),
//                 DataCell(Text(e.date)),
//                 DataCell(Text(e.time)),
//               ]),
//             )
//             .toList(),
//       ),
//     );
//   }
// }


//with responsive mode

import 'package:flutter/material.dart';
import 'package:pharma_app/provider/SalesReport.dart';
import 'package:provider/provider.dart';

class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key});

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  final _monthlyCtrl = TextEditingController();
  final _yearlyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SalesReportProvider>().load());
  }

  @override
  void dispose() {
    _monthlyCtrl.dispose();
    _yearlyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<SalesReportProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('📊 Sales Summary Report'),
      automaticallyImplyLeading: false,
      ),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Summary cards - responsive
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _summaryCard('Today\'s Sales', prov.todaySales, screenWidth,  const Color.fromARGB(255, 11, 100, 91)),
                          _summaryCard('Monthly Sales', prov.monthlySales, screenWidth, const Color.fromARGB(255, 161, 45, 45)),
                          _summaryCard('Yearly Sales', prov.yearlySales, screenWidth, const Color.fromARGB(255, 180, 128, 50)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Top Selling
                      _sectionCard(
                        title: '🏆 Top Selling Medicines',
                        child: _topSellingList(prov),
                      ),
                      const SizedBox(height: 16),

                      // Today details
                      _sectionCard(
                        title: '📅 Today\'s Medicine Sales (Details)',
                        child: _detailsTable(prov.detailedTodayList),
                      ),
                      const SizedBox(height: 16),

                      // Monthly details with search
                      _sectionCard(
                        title: '🗓️ Monthly Medicine Sales (Details)',
                        headerAction: _responsiveSearchBox(_monthlyCtrl, prov.filterMonthly, screenWidth),
                        child: _detailsTable(prov.filteredMonthlyList),
                      ),
                      const SizedBox(height: 16),

                      // Yearly details with search
                      _sectionCard(
                        title: '📆 Yearly Medicine Sales (Details)',
                        headerAction: _responsiveSearchBox(_yearlyCtrl, prov.filterYearly, screenWidth),
                        child: _detailsTable(prov.filteredYearlyList),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _summaryCard(String title, double amount, double screenWidth, Color bgColor) {
    double cardWidth = screenWidth < 600 ? (screenWidth / 2) - 24 : 260;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('৳ ${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? headerAction,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.blue.shade50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                if (headerAction != null) headerAction,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _topSellingList(SalesReportProvider prov) {
    if (prov.topSellingMedicines.isEmpty) {
      return const Text('No data');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prov.topSellingMedicines.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final e = prov.topSellingMedicines[i];
        return ListTile(
          dense: true,
          title: Text(e.key),
          trailing: Text('Qty: ${e.value}'),
        );
      },
    );
  }

  Widget _detailsTable(List<SalesItemDetail> items) {
    if (items.isEmpty) return const Text('No data');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
        columns: const [
          DataColumn(label: Text('Medicine')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price (৳)')),
          DataColumn(label: Text('Total (৳)')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Time')),
        ],
        rows: items
            .map(
              (e) => DataRow(cells: [
                DataCell(Text(e.name)),
                DataCell(Text(e.quantity.toString())),
                DataCell(Text(e.price.toStringAsFixed(2))),
                DataCell(Text(e.total.toStringAsFixed(2))),
                DataCell(Text(e.date)),
                DataCell(Text(e.time)),
              ]),
            )
            .toList(),
      ),
    );
  }

  Widget _responsiveSearchBox(TextEditingController controller, Function(String) onChanged, double screenWidth) {
    return SizedBox(
      width: screenWidth < 500 ? 180 : 280,
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search by name or date',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
