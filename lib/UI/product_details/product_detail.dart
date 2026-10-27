import 'package:flutter/material.dart';
import 'package:wordpress_app/model/woocommerce/product_model.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;

  const ProductDetail({super.key, this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
