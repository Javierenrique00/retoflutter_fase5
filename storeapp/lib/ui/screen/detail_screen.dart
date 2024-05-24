import 'package:apistorepackage/model/product/product_model.dart';
import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
      ),
      body: const Text('Detalle del producto'),
    );
  }
}
