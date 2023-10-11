import 'package:app/features/uikit_demo/ui_kit_demo_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Xin chao'),
      ),
      body: const UIKitDemoPage(),
    );
  }
}
