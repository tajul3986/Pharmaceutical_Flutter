import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// (optional) pretty date formatting: add intl in pubspec if you want
import 'package:intl/intl.dart';

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  State<OrderManagementPage> createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  // 👉 তোমার API base অনুযায়ী বদলে নাও
  final String baseUrl = 'http://localhost:8080/pharma';
  // common patterns: '/pharma/order' or '/pharma/orders'
  final String ordersUrlPath = '/orders'; // <-- এখানে path ঠিক করো

  bool _loading = false;
  String? _error;
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Uri get _ordersUri => Uri.parse('$baseUrl$ordersUrlPath');

  Future<void> _fetchOrders() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await http.get(_ordersUri);
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;
        _orders = data.cast<Map<String, dynamic>>();
        setState(() => _loading = false);
      } else {
        throw Exception('Failed with status ${res.statusCode}');
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Error loading orders: $e';
      });
    }
  }

  int _getTotalItems(Map<String, dynamic> order) {
    final items = (order['items'] as List?) ?? [];
    int total = 0;
    for (final it in items) {
      final m = it as Map<String, dynamic>;
      final q = m['quantity'];
      if (q is int) total += q;
      if (q is num) total += q.toInt();
    }
    return total;
  }

  String _formatDate(dynamic dateValue) {
    if (dateValue == null) return '';
    try {
      // most backends return ISO strings
      final dt = DateTime.tryParse(dateValue.toString())?.toLocal();
      if (dt == null) return dateValue.toString();
      // if intl available:
      return DateFormat('yMMMd • hh:mm a').format(dt);
    } catch (_) {
      return dateValue.toString();
    }
  }

  Future<void> _deleteOrder(int id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Order'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    try {
      final uri = Uri.parse('$baseUrl$ordersUrlPath/$id');
      final res = await http.delete(uri);
      if (res.statusCode == 200) {
        setState(() {
          _orders.removeWhere((o) => o['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order deleted')),
        );
      } else {
        throw Exception('Failed with status ${res.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive breakpoints
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900; // tablet landscape / desktop

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchOrders,
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text(_error!, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: _fetchOrders,
                          child: const Text('Retry'),
                        ),
                      ],
                    )
                  : _orders.isEmpty
                      ? ListView(
                          padding: const EdgeInsets.all(24),
                          children: const [
                            Center(
                              child: Text(
                                '🛒 No orders found.',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12),
                          child: isWide ? _buildTableView() : _buildCardListView(),
                        ),
        ),
      ),
    );
  }

  /// Desktop/Tablet: DataTable with horizontal scroll
  Widget _buildTableView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                headingRowHeight: 48,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 72,
                columns: const [
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Order Code')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Items')),
                  DataColumn(label: Text('Total (৳)')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Action')),
                ],
                rows: _orders.map((o) {
                  final id = o['id'] as int?;
                  return DataRow(cells: [
                    DataCell(Text(o['customerName']?.toString() ?? '')),
                    DataCell(Text('#${o['orderCode'] ?? ''}')),
                    DataCell(Text(o['phone']?.toString() ?? '')),
                    DataCell(SizedBox(
                      width: 260,
                      child: Text(
                        o['address']?.toString() ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataCell(Text('${_getTotalItems(o)} items')),
                    DataCell(Text('${o['total'] ?? ''}')),
                    DataCell(Text(_formatDate(o['date']))),
                    DataCell(
                      IconButton(
                        tooltip: 'Delete',
                        onPressed: id == null ? null : () => _deleteOrder(id),
                        color: Colors.red,
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Mobile: Card list
  Widget _buildCardListView() {
    return ListView.separated(
      itemCount: _orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final o = _orders[index];
        final id = o['id'] as int?;
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        o['customerName']?.toString() ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '#${o['orderCode'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _kv('Phone', o['phone']),
                _kv('Address', o['address']),
                _kv('Items', '${_getTotalItems(o)} items'),
                _kv('Total (৳)', o['total']),
                _kv('Date', _formatDate(o['date'])),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton.filledTonal(
                    onPressed: id == null ? null : () => _deleteOrder(id),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _kv(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value?.toString() ?? '')),
        ],
      ),
    );
  }
}


//with table formate

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class OrderManagementPage extends StatefulWidget {
//   const OrderManagementPage({super.key});

//   @override
//   State<OrderManagementPage> createState() => _OrderManagementPageState();
// }

// class _OrderManagementPageState extends State<OrderManagementPage> {
//   final String baseUrl = 'http://localhost:8080/pharma';
//   final String ordersUrlPath = '/orders';

//   bool _loading = false;
//   String? _error;
//   List<Map<String, dynamic>> _orders = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchOrders();
//   }

//   Uri get _ordersUri => Uri.parse('$baseUrl$ordersUrlPath');

//   Future<void> _fetchOrders() async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });
//     try {
//       final res = await http.get(_ordersUri);
//       if (res.statusCode == 200) {
//         final data = json.decode(res.body) as List<dynamic>;
//         _orders = data.cast<Map<String, dynamic>>();
//         setState(() => _loading = false);
//       } else {
//         throw Exception('Failed with status ${res.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         _loading = false;
//         _error = 'Error loading orders: $e';
//       });
//     }
//   }

//   int _getTotalItems(Map<String, dynamic> order) {
//     final items = (order['items'] as List?) ?? [];
//     int total = 0;
//     for (final it in items) {
//       final m = it as Map<String, dynamic>;
//       final q = m['quantity'];
//       if (q is int) total += q;
//       if (q is num) total += q.toInt();
//     }
//     return total;
//   }

//   String _formatDate(dynamic dateValue) {
//     if (dateValue == null) return '';
//     try {
//       final dt = DateTime.tryParse(dateValue.toString())?.toLocal();
//       if (dt == null) return dateValue.toString();
//       return DateFormat('yMMMd • hh:mm a').format(dt);
//     } catch (_) {
//       return dateValue.toString();
//     }
//   }

//   Future<void> _deleteOrder(int id) async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Delete Order'),
//         content: const Text('Are you sure you want to delete this order?'),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: Colors.red),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//     if (ok != true) return;

//     try {
//       final uri = Uri.parse('$baseUrl$ordersUrlPath/$id');
//       final res = await http.delete(uri);
//       if (res.statusCode == 200) {
//         setState(() {
//           _orders.removeWhere((o) => o['id'] == id);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Order deleted')),
//         );
//       } else {
//         throw Exception('Failed with status ${res.statusCode}');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Delete failed: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (_error != null) {
//       return Scaffold(
//         body: Center(child: Text(_error!)),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Order Management"),
//       automaticallyImplyLeading: false, // ← back arrow hide করবে
//       ),

//       body: RefreshIndicator(
//         onRefresh: _fetchOrders,
//         child: _orders.isEmpty
//             ? const Center(child: Text("🛒 No orders found."))
//             : SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   headingRowColor: MaterialStateProperty.all(Colors.blue.shade100),
//                   columns: const [
//                     DataColumn(label: Text('Customer')),
//                     DataColumn(label: Text('Order Code')),
//                     DataColumn(label: Text('Phone')),
//                     DataColumn(label: Text('Address')),
//                     DataColumn(label: Text('Items')),
//                     DataColumn(label: Text('Total (৳)')),
//                     DataColumn(label: Text('Date')),
//                     DataColumn(label: Text('Action')),
//                   ],
//                   rows: _orders.map((o) {
//                     final id = o['id'] as int?;
//                     return DataRow(cells: [
//                       DataCell(Text(o['customerName']?.toString() ?? '')),
//                       DataCell(Text('#${o['orderCode'] ?? ''}')),
//                       DataCell(Text(o['phone']?.toString() ?? '')),
//                       DataCell(SizedBox(
//                         width: 200,
//                         child: Text(
//                           o['address']?.toString() ?? '',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       )),
//                       DataCell(Text('${_getTotalItems(o)} items')),
//                       DataCell(Text('${o['total'] ?? ''}')),
//                       DataCell(Text(_formatDate(o['date']))),
//                       DataCell(
//                         IconButton(
//                           tooltip: 'Delete',
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: id == null ? null : () => _deleteOrder(id),
//                         ),
//                       ),
//                     ]);
//                   }).toList(),
//                 ),
//               ),
//       ),
//     );
//   }
// }


