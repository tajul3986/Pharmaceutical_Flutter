import 'package:flutter/material.dart';
import 'package:pharma_app/provider/DashboardProvider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? touchedBarIndex;
  int? touchedPieIndex;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      child: Scaffold(
        // appBar: AppBar(
        //   //title: const Text("Dashboard"),
        //   automaticallyImplyLeading: false, // ← back arrow hide করবে
        //   centerTitle: true,
        // ),
        body: SafeArea(
          child: Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }

              final screenWidth = MediaQuery.of(context).size.width;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Summary Cards (Responsive 2-column) =====
                    LayoutBuilder(builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _summaryCard("Total Medicines", provider.totalMedicines, Colors.teal.shade300),
                          _summaryCard("Stock Alerts", provider.stockAlerts, Colors.red.shade300),
                          _summaryCard("Monthly Sales", provider.monthlySales.toInt(), Colors.blue.shade300),
                          _summaryCard("New Orders", provider.newOrders, Colors.orange.shade300),
                        ],
                      );
                    }),

                    const SizedBox(height: 24),

                    // ===== Bar Chart =====
                    const Text("📊 Monthly Sales",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: screenWidth < 600 ? 220 : 320,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: _buildBarChart(provider),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ===== Pie Chart =====
                    const Text("🥧 Stock Distribution",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: screenWidth < 600 ? 250 : 350,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: _buildPieChart(provider),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ===== Recent Orders Table =====
                    const Text("📦 Recent Orders",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Order ID")),
                            DataColumn(label: Text("Medicine")),
                            DataColumn(label: Text("Quantity")),
                            DataColumn(label: Text("Date")),
                          ],
                          rows: provider.recentOrders.map((order) {
                            final item = order.items!.first;
                            return DataRow(cells: [
                              DataCell(Text(order.id.toString())),
                              DataCell(Text(item.name ?? 'Unknown')),
                              DataCell(Text(item.quantity.toString())),
                              DataCell(Text(order.date.toString())),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ===== Summary Card Widget =====
  Widget _summaryCard(String title, int value, Color bgColor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 8),
            Text("$value",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // ===== Bar Chart Widget (Left labels removed) =====
  Widget _buildBarChart(DashboardProvider provider) {
    final keys = provider.barChartData.keys.toList();
    final values = provider.barChartData.values.toList();

    return BarChart(
      BarChartData(
        maxY: (values.isNotEmpty
                ? values.reduce((a, b) => a > b ? a : b)
                : 10)
            .toDouble() + 5,
        barGroups: List.generate(keys.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i].toDouble(),
                color: touchedBarIndex == i ? Colors.orange : Colors.blue,
                width: 18,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
            showingTooltipIndicators: touchedBarIndex == i ? [0] : [],
          );
        }),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= keys.length) return const SizedBox();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    keys[index],
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              reservedSize: 42,
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // <-- hide left labels
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${keys[group.x.toInt()]}\nQty Sold: ${rod.toY.toInt()}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
          touchCallback: (event, response) {
            if (response == null || response.spot == null) {
              setState(() {
                touchedBarIndex = null;
              });
              return;
            }
            setState(() {
              touchedBarIndex = response.spot!.touchedBarGroupIndex;
            });
          },
        ),
      ),
    );
  }

  // ===== Pie Chart Widget =====
  Widget _buildPieChart(DashboardProvider provider) {
    final entries = provider.pieChartData.entries.toList();

    return PieChart(
      PieChartData(
        sections: List.generate(entries.length, (i) {
          final e = entries[i];
          final isTouched = touchedPieIndex == i;
          final double radius = isTouched ? 100 : 80;
          final color = Colors.primaries[i % Colors.primaries.length];

          return PieChartSectionData(
            color: color,
            value: e.value.toDouble(),
            title: '${e.key}\n${e.value}',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            titlePositionPercentageOffset: 0.5,
            badgeWidget: isTouched ? _badge(e.key) : null,
            badgePositionPercentageOffset: 1.1,
          );
        }),
        pieTouchData: PieTouchData(
          touchCallback: (event, response) {
            if (response == null || response.touchedSection == null) {
              setState(() {
                touchedPieIndex = null;
              });
              return;
            }
            setState(() {
              touchedPieIndex = response.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  // ===== Badge Widget for Pie Chart =====
  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
