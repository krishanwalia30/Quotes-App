import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/utils/routes.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FEEDBACK FORM'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text('Feedback'),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  maxLength: 1000,
                  maxLines: 7,
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter Feedback',
                    filled: true,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some feedback';
                    }
                    return null;
                  },
                ),
              ),
            ),
            // This code is for the reset button.
            // ElevatedButton(
            //   onPressed: () =>
            //       // Navigator.PushNamed(context, MyRoutes.feedbackRoute),
            //       Navigator.pop,
            //   child: const Text('Reset'),
            // ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // the code to send the data to the firestore
                  if (_formkey.currentState!.validate()) {
                    String message;
                    try {
                      final collection =
                          FirebaseFirestore.instance.collection('Feedbacks');
                      await collection.doc().set({
                        // the things that we want to send to the database in one feedback
                        'timestamp': FieldValue.serverTimestamp(),
                        'feedback': _controller.text,
                      });
                      message = 'Feedback Sent Successfully';
                    } catch (_) {
                      //if something goes wrong while sending the data
                      message = 'Error while sending the feedback';
                    }
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                    Navigator.popAndPushNamed(context, MyRoutes.feedbackRoute);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
