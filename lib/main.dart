import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'dart:ui';
import 'package:toast/toast.dart';
import 'SplashScreen.dart';
import 'ShopPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset("assets/adidas.jpg").image,
                      fit: BoxFit.fill)),
              child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.15)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: Image.asset("assets/adidas2.png").image,
                          height: 150,
                          width: 150,
                        ),
                        height: 240,
                      ),
                      Container(
                        height: 100,
                      ),
                      Container(
                        width: 260,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GoogleSignInButton(
                          onPressed: () {
                            _handleGoogleSignIn(context)
                                .then((FirebaseUser user) =>
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Shop(_googleSignIn,_auth)),
                                    ))
                                .catchError((e) =>  Toast.show("Log Canceled", context,duration: 3,backgroundColor: Colors.white10));
                          },
                          darkMode: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleGoogleSignIn(BuildContext con) async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  if(googleUser.authentication == null){
     return null;
  }else
  {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("Usuario ingresado:" + user.displayName);
    return user;
  }
}

