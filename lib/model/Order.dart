// class OrderItem {
//   int? id;
//   String? name;
//   int? quantity;
//   double? price;
//   String? orderDate;

//   OrderItem({this.id, this.name, this.quantity, this.price, this.orderDate});

//   Map<String, dynamic> toJson() => {
//         if (id != null) 'id': id,
//         'name': name,
//         'quantity': quantity,
//         'price': price,
//         if (orderDate != null) 'orderDate': orderDate,
//       };
// }

// class Order {
//   int? id;
//   String? orderCode;
//   DateTime? date;
//   String? customerName;
//   String? phone;
//   String? paymentMethod; // 'cod', 'card', or 'mobile'
//   String? mobileType;
//   String? address;
//   List<OrderItem>? items;
//   double? subtotal;
//   double? vat;
//   double? deliveryFee;
//   double? total;

//   Order({
//     this.id,
//     this.orderCode,
//     this.date,
//     this.customerName,
//     this.phone,
//     this.paymentMethod,
//     this.mobileType,
//     this.address,
//     this.items,
//     this.subtotal,
//     this.vat,
//     this.deliveryFee,
//     this.total,
//   });

//   Map<String, dynamic> toJson() => {
//         if (id != null) 'id': id,
//         if (orderCode != null) 'orderCode': orderCode,
//         if (date != null) 'date': date!.toIso8601String(),
//         'customerName': customerName,
//         'phone': phone,
//         if (paymentMethod != null) 'paymentMethod': paymentMethod,
//         if (mobileType != null) 'mobileType': mobileType,
//         'address': address,
//         'items': items?.map((item) => item.toJson()).toList(),
//         if (subtotal != null) 'subtotal': subtotal,
//         if (vat != null) 'vat': vat,
//         if (deliveryFee != null) 'deliveryFee': deliveryFee,
//         if (total != null) 'total': total,
//       };
// }

//2nd
class OrderItem {
  int? id;
  String? name;
  int? quantity;
  double? price;
  String? orderDate;

  OrderItem({this.id, this.name, this.quantity, this.price, this.orderDate});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      orderDate: json['orderDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        if (orderDate != null) 'orderDate': orderDate,
      };
}

class Order {
  int? id;
  String? orderCode;
  DateTime? date;
  String? customerName;
  String? phone;
  String? paymentMethod; // 'cod', 'card', or 'mobile'
  String? mobileType;
  String? address;
  List<OrderItem>? items;
  double? subtotal;
  double? vat;
  double? deliveryFee;
  double? total;

  Order({
    this.id,
    this.orderCode,
    this.date,
    this.customerName,
    this.phone,
    this.paymentMethod,
    this.mobileType,
    this.address,
    this.items,
    this.subtotal,
    this.vat,
    this.deliveryFee,
    this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderCode: json['orderCode'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      customerName: json['customerName'],
      phone: json['phone'],
      paymentMethod: json['paymentMethod'],
      mobileType: json['mobileType'],
      address: json['address'],
      items: json['items'] != null
          ? List<OrderItem>.from(
              (json['items'] as List).map((item) => OrderItem.fromJson(item)))
          : null,
      subtotal: json['subtotal'] != null ? (json['subtotal'] as num).toDouble() : null,
      vat: json['vat'] != null ? (json['vat'] as num).toDouble() : null,
      deliveryFee: json['deliveryFee'] != null ? (json['deliveryFee'] as num).toDouble() : null,
      total: json['total'] != null ? (json['total'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (orderCode != null) 'orderCode': orderCode,
        if (date != null) 'date': date!.toIso8601String(),
        'customerName': customerName,
        'phone': phone,
        if (paymentMethod != null) 'paymentMethod': paymentMethod,
        if (mobileType != null) 'mobileType': mobileType,
        'address': address,
        'items': items?.map((item) => item.toJson()).toList(),
        if (subtotal != null) 'subtotal': subtotal,
        if (vat != null) 'vat': vat,
        if (deliveryFee != null) 'deliveryFee': deliveryFee,
        if (total != null) 'total': total,
      };
}



