import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text('لا توجد إعدادات حالياً.', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
