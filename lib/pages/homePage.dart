import 'package:flutter/material.dart';
import 'package:quotes_app/pages/loginPage.dart';
import 'package:quotes_app/utils/routes.dart';
import 'package:quotes_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loginpagestate = new LoginPageState();
  late var sname = "";
  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sname = (prefs.getString('name') ?? "");
    });
  }

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
            Text("Hello $sname"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.quotesRoute);
              },
              child: const Text('Show Quotes'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.userquotesRoute);
                },
                child: const Text('YOUR QUOTES')),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
