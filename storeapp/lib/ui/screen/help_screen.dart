import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:atomicdesign/ui/page/help_page.dart';
import 'package:flutter/material.dart';

import 'help_data/help_data.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and contact'),
        backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: const HelpPage(
            helpTitle: 'Help',
            helpMsg: HelpData.helpContent,
            contactTitle: 'Contact Us',
            contactMsg: HelpData.contactContent),
      ),
    );
  }
}
