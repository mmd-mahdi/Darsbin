class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final bool inStock;
  final double rating;
  final DateTime addedDate;
  final bool isOnSale;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.inStock,
    required this.rating,
    required this.addedDate,
    required this.isOnSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      inStock: json['inStock'] as bool,
      rating: (json['rating'] as num).toDouble(),
      addedDate: DateTime.parse(json['addedDate'] as String),
      isOnSale: json['isOnSale'] as bool,
    );
  }

  // Helper method to convert back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'inStock': inStock,
      'rating': rating,
      'addedDate': addedDate.toIso8601String(),
      'isOnSale': isOnSale,
    };
  }
}