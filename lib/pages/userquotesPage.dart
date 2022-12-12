import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/utils/routes.dart';

class UserQuotesPage extends StatefulWidget {
  late final String quote;
  late final String username;

  @override
  State<UserQuotesPage> createState() => _UserQuotesPageState();
}

class _UserQuotesPageState extends State<UserQuotesPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR QUOTES'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("UserQuotes").snapshots(),
        builder: (context, snapshot) {
          return (!snapshot.hasData)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];

                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.amber.shade100,
                      child: ListTile(
                        title: Text(
                          document['quote'],
                          style: GoogleFonts.pacifico(
                            color: Colors.deepOrange,
                            fontSize: 30,
                          ),
                        ),
                        subtitle: Text(
                            "By- " + document["username"]),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("the floating action button on the yourQUotes page is clicked");
          Navigator.pushNamed(context, MyRoutes.addquoteRoute);
          // TO move to user to add his quote page.
        },
      ),
    );
  }
}
