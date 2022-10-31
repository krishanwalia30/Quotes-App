import 'package:flutter/material.dart';
import 'package:quotes_app/utils/routes.dart';
import 'package:quotes_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QUOTES APP',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.quotesRoute);
                },
                child: const Text('Show Quotes'))
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
