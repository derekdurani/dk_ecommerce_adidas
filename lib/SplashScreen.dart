import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/adidas.jpg").image,
                    fit: BoxFit.fill)),
            child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Container(height: 550),
                        CircularProgressIndicator(backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),)
                      ],
                    )
                  ),
                )
            )
        )
    );
  }
}
