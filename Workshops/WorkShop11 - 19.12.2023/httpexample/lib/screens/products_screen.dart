import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpexample/models/productResponse.dart';
import 'package:httpexample/widgets/product_item.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    Uri url = Uri.https("dummyjson.com", "products");

    final response = await http.get(url);

    final dataAsJson = jsonDecode(response.body);

    List<Product> products = [];

    for (var productJson in dataAsJson["products"]) {
      Product product = Product.fromJson(productJson);
      products.add(product);
    }

    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (ctx, index) => ProductItem(product: productList[index]),
      ),
    );
  }
}