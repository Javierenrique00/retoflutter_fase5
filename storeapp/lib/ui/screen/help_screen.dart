import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and contact'),
        backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
      ),
      body: const Text('Help Screen'), );
  }
}