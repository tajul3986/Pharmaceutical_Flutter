class Medicine {
  final int? id;
  final String? productCode;
  final String? name;
  final double? price;
  final String? description;
  final String? category;
  final String? subcategory;
  final int stock;
  final String ? image;

  Medicine({
    this.id,
    required this.productCode,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.stock,
    required this.image,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    //const baseUrl = "http://localhost:8080/image/";

    return Medicine(
      id: json['id'],
      productCode: json['productCode'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      subcategory: json['subcategory'],
      stock: json['stock'],
       //image: json['image'] != null ? baseUrl + json['image']:null,

      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'stock': stock,
      'image': image,
    };
  }
}


//from angular

// class Medicine {
//   int? id;
//   String? productCode;
//   String? name;
//   double? price;
//   String? description;
//   String? category;
//   String? subcategory;
//   int? stock;
//   String? image;

//   Medicine({
//     this.id,
//     this.productCode,
//     this.name,
//     this.price,
//     this.description,
//     this.category,
//     this.subcategory,
//     this.stock,
//     this.image,
//   });

//   factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
//         id: json['id'],
//         productCode: json['productCode'],
//         name: json['name'],
//         price: (json['price'] ?? 0).toDouble(),
//         description: json['description'],
//         category: json['category'],
//         subcategory: json['subcategory'],
//         stock: json['stock'],
//         image: json['image'],
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'productCode': productCode,
//         'name': name,
//         'price': price,
//         'description': description,
//         'category': category,
//         'subcategory': subcategory,
//         'stock': stock,
//         'image': image,
//       };
// }

