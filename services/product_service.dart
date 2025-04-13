// import 'dart:convert';
// import 'package:flutter/services.dart';
// import '../models/product.dart';

// //class ProductService {
//   static Future<List<Product>> loadProducts() async {
//       //این کده خب اول میاد فایل جیسون رو میخونه و به صورت خام رشته داخل یه متغیر ذحیر میکنه 

//     final jsonString = await rootBundle.loadString('assets/products.json');
//       //رشته بالا تبدیل به یک دیتا استراکچر میشه که یک لیست هست و هر عنصر لیست یک مپ همون دیکشنری پایتون هست 

//     final List<dynamic> jsonList = json.decode(jsonString);
//       // اینجا میایم لیست بالا رو تبدیل به یک لیست از کلاس ایتم که گفتیم هر کدومش دیتا کلاس هست میکنیم 

//     return jsonList.map((json) => Product.fromJson(json)).toList();
//   }

//   // Method 1: Keep first occurrence of each name
//   static Future<List<Product>> getUniqueProducts() async {
//     final products = await loadProducts();
//     final uniqueProducts = <String, Product>{};
    
//     for (final product in products) {
//       if (!uniqueProducts.containsKey(product.name)) {
//         uniqueProducts[product.name] = product;
//       }
//     }
    
//     return uniqueProducts.values.toList();
//   }

//   // Method 2: Keep highest priced item for duplicates
//   static Future<List<Product>> getUniqueProductsKeepHighestPrice() async {
//     final products = await loadProducts();
//     final uniqueProducts = <String, Product>{};
    
//     for (final product in products) {
//       if (!uniqueProducts.containsKey(product.name)) {
//         uniqueProducts[product.name] = product;
//       } else if (product.price > uniqueProducts[product.name]!.price) {
//         uniqueProducts[product.name] = product;
//       }
//     }
    
//     return uniqueProducts.values.toList();
//   }
//   static Future<List<Product>> getElectronics() async {
//     final products = await _loadAllProducts();
//     return products.where((p) => p.category == 'Electronics').toList();
//   }

//   // 2. Price range filter
//   static Future<List<Product>> getProductsInPriceRange(double min, double max) async {
//     final products = await _loadAllProducts();
//     return products.where((p) => p.price >= min && p.price <= max).toList();
//   }

//   // 3. In-stock items filter
//   static Future<List<Product>> getInStockProducts() async {
//     final products = await _loadAllProducts();
//     return products.where((p) => p.inStock).toList();
//   }

//   // 4. Search by name (case-insensitive)
//   static Future<List<Product>> searchProducts(String query) async {
//     final products = await _loadAllProducts();
//     return products.where((p) => 
//         p.name.toLowerCase().contains(query.toLowerCase())).toList();
//   }
// }
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  // Filter by exact category
  static Future<List<Product>> getByCategory(String category) async {
    final products = await loadProducts();
    return products.where((p) => p.category == category).toList();
  }

  // Filter by price range
  static Future<List<Product>> getByPriceRange(double min, double max) async {
    final products = await loadProducts();
    return products.where((p) => p.price >= min && p.price <= max).toList();
  }

  // Filter by availability
  static Future<List<Product>> getInStockProducts() async {
    final products = await loadProducts();
    return products.where((p) => p.inStock).toList();
  }

  // Filter by rating
  static Future<List<Product>> getHighlyRated(double minRating) async {
    final products = await loadProducts();
    return products.where((p) => p.rating >= minRating).toList();
  }

  // Filter by date added
  static Future<List<Product>> getRecentlyAdded(int days) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final products = await loadProducts();
    return products.where((p) => p.addedDate.isAfter(cutoffDate)).toList();
  }

  // Filter by sale status
  static Future<List<Product>> getSaleItems() async {
    final products = await loadProducts();
    return products.where((p) => p.isOnSale).toList();
  }

  // Combined search filter
  static Future<List<Product>> searchProducts({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? inStock,
    double? minRating,
  }) async {
    final products = await loadProducts();
    return products.where((p) {
      bool matches = true;
      
      if (query != null && query.isNotEmpty) {
        matches = matches && 
            (p.name.toLowerCase().contains(query.toLowerCase()) ||
             p.description.toLowerCase().contains(query.toLowerCase()));
      }
      
      if (category != null) {
        matches = matches && p.category == category;
      }
      
      if (minPrice != null) {
        matches = matches && p.price >= minPrice;
      }
      
      if (maxPrice != null) {
        matches = matches && p.price <= maxPrice;
      }
      
      if (inStock != null) {
        matches = matches && p.inStock == inStock;
      }
      
      if (minRating != null) {
        matches = matches && p.rating >= minRating;
      }
      
      return matches;
    }).toList();
  }
}