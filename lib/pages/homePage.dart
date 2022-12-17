import 'package:flutter/material.dart';
import 'package:quotes_app/pages/example.dart';
import 'package:quotes_app/pages/favouritesPage.dart';
// import 'package:quotes_app/pages/loginPage.dart';
import 'package:quotes_app/pages/quotesPage.dart';
import 'package:quotes_app/utils/fileManager.dart';
import 'package:quotes_app/widgets/drawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> _pages = <Widget>[
    QuotesPage(),
    // Icon(
    //   Icons.link,
    //   size: 150,
    // ),
    FavouritePage(),
    // Icon(
    //   Icons.settings,
    //   size: 150,
    // ),
    // AnimatedListSample(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // var loginpagestate = new LoginPageState();
  // late var sname = "";
  // @override
  // void initState() {
  //   super.initState();
  //   loadName();
  // }

  // Future<void> loadName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     sname = (prefs.getString('name') ?? "");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QUOTES APP',
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote_rounded),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link_rounded),
            label: 'Favourites',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          // ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
