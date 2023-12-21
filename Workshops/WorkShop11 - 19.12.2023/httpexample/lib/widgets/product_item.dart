import 'package:flutter/material.dart';
import 'package:httpexample/models/productResponse.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(125, 76, 175, 1),
          boxShadow: const [
            BoxShadow(
              blurRadius: 23,
              offset: Offset(2, 4),
              color: Colors.white,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 20, 37, 134),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Discount: ${product.discountPercentage} %',
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}