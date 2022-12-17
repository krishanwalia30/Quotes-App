import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late String name = "";

  @override
  void initState() {
    super.initState();
    loadName();
  }

  //Loading name value on start
  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    name = (prefs.getString('name') ?? "");
    setState(() {
      name = (prefs.getString('name') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    const imgUrl =
        "https://jnvetah-alumni.in/wp-content/uploads/jet-engine-forms/1/2021/09/undraw_profile_pic_ic5t-1.png";
    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(children: [
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            color: Colors.amber,
            height: 82,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(imgUrl),
              radius: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text('$name'),
          ),
          const ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: Icon(
              CupertinoIcons.home,
              size: 33.0,
            ),
            title: Text(
              "Home",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: Icon(
              CupertinoIcons.moon_circle,
              size: 33.0,
            ),
            title: Text(
              "DarkMode",
              textScaleFactor: 1.2,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.feedbackRoute);
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(
              CupertinoIcons.f_cursive_circle,
              size: 33.0,
            ),
            title: const Text(
              "Feedback",
              textScaleFactor: 1.2,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.aboutusRoute);
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(
              CupertinoIcons.info,
              size: 33.0,
            ),
            title: const Text(
              "About Us",
              textScaleFactor: 1.2,
            ),
          )
        ]),
      ),
    );
  }
}
