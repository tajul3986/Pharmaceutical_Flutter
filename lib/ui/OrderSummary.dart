import 'package:flutter/material.dart';
import 'package:pharma_app/ui/Payment.dart';

class OrderSummaryDialog extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const OrderSummaryDialog({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
  });

  double getItemsTotal() {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  double getDeliveryFee() => 50;
  double getVAT() => getItemsTotal() * 0.15;
  double getSubtotal() => getItemsTotal() + getVAT();
  double getGrandTotal() => getSubtotal() + getDeliveryFee();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildPriceRow(
              "Items Price (${cartItems.length} items)",
              getItemsTotal(),
            ),
            _buildPriceRow("VAT (15%)", getVAT()),
            _buildPriceRow("Subtotal", getItemsTotal() + getVAT()),
            _buildPriceRow("Delivery Fee", getDeliveryFee()),
            const Divider(height: 20),
            _buildPriceRow("Grand Total", getGrandTotal(), isTotal: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        cartItems: cartItems,
                        deliveryInfo: deliveryInfo,
                        subtotal: getItemsTotal(),
                        vat: getVAT(),
                        deliveryFee: getDeliveryFee(),
                        total: getGrandTotal(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("PROCEED TO PAYMENT"),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text("Secure Checkout", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "৳${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
