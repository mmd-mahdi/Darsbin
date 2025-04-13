import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;
  bool showHighestPrice = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      futureProducts = showHighestPrice
          ? ProductService.getUniqueProductsKeepHighestPrice()
          : ProductService.getUniqueProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unique Products'),
        actions: [
          Switch(
            value: showHighestPrice,
            onChanged: (value) {
              setState(() {
                showHighestPrice = value;
                _loadProducts();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(
              child: Text(showHighestPrice ? 'High Price' : 'First'),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading products'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('ID: ${product.id}'),
                  trailing: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}