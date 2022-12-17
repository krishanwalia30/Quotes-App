import 'package:flutter/material.dart';

class AboutusPage extends StatelessWidget {
  const AboutusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUOTES APP'),
      ),
      body: const Text('About Us Page'),
    );
  }
}