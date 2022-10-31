import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  // context is basically the element we have to use to render on the app page.
  // widget tree=> element tree => render tree,
  @override
  Widget build(BuildContext context) {
    const imgUrl =
        "https://jnvetah-alumni.in/wp-content/uploads/jet-engine-forms/1/2021/09/undraw_profile_pic_ic5t-1.png";
    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(children: const [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                margin: EdgeInsets.zero,
                accountName: const Text('Krishan Walia'),
                accountEmail: const Text('krishanw30@gmail.com'),
                // currentAccountPicture: Image.network(imgUrl),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imgUrl),
                ),
              )),
          ListTile(
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
          ListTile(
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
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: Icon(
              CupertinoIcons.f_cursive_circle,
              size: 33.0,
            ),
            title: Text(
              "Feedback",
              textScaleFactor: 1.2,
            ),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: Icon(
              CupertinoIcons.info,
              size: 33.0,
            ),
            title: Text(
              "About Us",
              textScaleFactor: 1.2,
            ),
          )
        ]),
      ),
    );
  }
}