import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(List<Map<String, dynamic>>) onCartUpdated;

  const ProductPage({
    super.key,
    required this.cartItems,
    required this.onCartUpdated,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

enum SortOrder { none, priceAsc, priceDesc }

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];

  final String baseUrl = "http://localhost:8080";

  bool isDarkMode = false;
  SortOrder currentSortOrder = SortOrder.none;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        final name = (product['name'] ?? '').toString().toLowerCase();
        return name.contains(query);
      }).toList();
      _applySorting();
    });
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pharma/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          filteredProducts = List.from(allProducts);
          _applySorting();
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _applySorting() {
    if (currentSortOrder == SortOrder.priceAsc) {
      filteredProducts.sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
    } else if (currentSortOrder == SortOrder.priceDesc) {
      filteredProducts.sort((a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0));
    }
  }

  void _changeSortOrder(SortOrder order) {
    setState(() {
      currentSortOrder = order;
      _applySorting();
    });
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    final size = MediaQuery.of(context).size;

    int crossAxisCount;
    if (size.width >= 1200) {
      crossAxisCount = 5;
    } else if (size.width >= 900) {
      crossAxisCount = 4;
    } else if (size.width >= 600) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Available Medicines'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.green[700],
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleDarkMode,
          ),
          PopupMenuButton<SortOrder>(
            onSelected: _changeSortOrder,
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              const PopupMenuItem(value: SortOrder.none, child: Text('No Sorting')),
              const PopupMenuItem(value: SortOrder.priceAsc, child: Text('Price: Low to High')),
              const PopupMenuItem(value: SortOrder.priceDesc, child: Text('Price: High to Low')),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search medicine...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No medicines found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: size.width < 400 ? 0.55 : 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final imageUrl = '$baseUrl/image/${product["image"] ?? "default.jpg"}';

                  return Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            imageUrl,
                            height: size.height * 0.2, // slightly bigger for visibility
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/images/default_medicine.png',
                              height: size.height * 0.2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width < 400 ? 13 : 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Stock: ${product['stock'] ?? ''}",
                                style: TextStyle(fontSize: size.width < 400 ? 11 : 12),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "৳${product['price'] ?? '0'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width < 400 ? 14 : 16,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: size.height * 0.05, // responsive button height
                            child: ElevatedButton(
                              onPressed: () {
                                widget.cartItems.add({
                                  'name': product['name'],
                                  'price': product['price'],
                                  'imageUrl': imageUrl,
                                });
                                widget.onCartUpdated(widget.cartItems);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 11, 87, 70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}