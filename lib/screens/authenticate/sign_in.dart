import 'package:firebaseapp/shared/constants.dart';
import 'package:firebaseapp/shared/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:firebaseapp/services/auth.dart';
import 'package:firebaseapp/models/user.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool spinkit = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return spinkit
        ? Spinkit()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'abc@gmail.com'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: (val) =>
                              val.length < 6 ? 'Enter your password' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => spinkit = true);
                              dynamic result = await _auth
                                  .signInWithEmailandPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Signin failed!!!';
                                  spinkit = false;
                                });
                              }
                            }
                          },
                          color: Colors.pink[400],
                          child: Text('Sign in',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ))),
          );
  }
}
