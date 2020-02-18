import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/models/user.dart';
import 'package:firebaseapp/screens/authenticate/authenticate.dart';
import 'package:firebaseapp/screens/home/user_list.dart';
import 'package:firebaseapp/services/auth.dart';
import 'package:firebaseapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Logout'))
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
