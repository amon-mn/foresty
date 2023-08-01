import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({super.key, required this.user});

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
            color: Color.fromARGB(255, 0, 90, 3),
          )
        ],
      ),
      body: Center(
        child: Text(
          "Login realizado por " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
