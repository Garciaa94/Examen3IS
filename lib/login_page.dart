import 'Utils/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
      LoginPage({Key key}) : super(key: key);  
    
    @override
   _LoginPageState createState() => _LoginPageState();
     
    }
  
  
  class _LoginPageState extends State<LoginPage> {
    TextEditingController _emailController;
    TextEditingController _passwordController;

    @override
  void initState() { 
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
          children: <Widget>[
            const SizedBox(height: 100.0,),
            Text("Login", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            const SizedBox(height: 20.0),
            RaisedButton.icon(
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();

                  if (!res) {
                    print("error logging in with google");
                  } else
                    Navigator.pushNamed(context, 'home', arguments: false);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Usuario Cliente',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.perm_contact_calendar,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.lightBlue,
              ),
            TextField(
               controller: _emailController,
               decoration: InputDecoration(
               hintText: "Enter Email"
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter Password"
              ),
            ),
            const SizedBox(height: 10.0),
             RaisedButton.icon(
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().signInWithEmail(
                      _emailController.text, _passwordController.text);

                  if (!res) {
                    Navigator.pushNamed(context, 'home', arguments: true);
                    print("Login failed");
                  } else
                    Navigator.pushNamed(context, 'home', arguments: true);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Usuario Administrador',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.lightBlue,
              ),
          ],
          ),
        ),
      ),
    );
  }


  }

