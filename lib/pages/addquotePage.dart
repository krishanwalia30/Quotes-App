import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routes.dart';

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({super.key});

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _quotecontroller = TextEditingController();

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _quotecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD YOUR QUOTE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Add Your Quote'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: _usernamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: _quotecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your quote',
                      filled: true,
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your quote';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // The code to submit the quote of the user to the firestore
                      if (_formkey.currentState!.validate()) {
                        String message;
                        try {
                          final collection = FirebaseFirestore.instance
                              .collection('UserQuotes');
                          await collection.doc().set({
                            'timestamp': FieldValue.serverTimestamp(),
                            'quote': _quotecontroller.text,
                            'username': _usernamecontroller.text,
                          });
                          message = 'Quote uploaded successfully';
                        } catch (e) {
                          // if something goes wrong in uploading the quote
                          print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n');
                          print(e.toString());
                          print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n');

                          message = 'Error occured while uploading the quote';
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                        Navigator.popAndPushNamed(
                            context, MyRoutes.addquoteRoute);
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}