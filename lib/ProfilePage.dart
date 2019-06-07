import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

import 'main.dart';


class ProfilePage extends StatelessWidget {

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  ProfilePage(this.googleSignIn,this.auth);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: GoogleSignInButton(
          text: "Sign Out",
          onPressed: () {
            _signOut(googleSignIn,auth);
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => LoginPage()),ModalRoute.withName('/'));
            Toast.show("Session closed successfully", context,duration: 3);
                
          },
        ),
      ),
    );
  }
}

void _signOut(GoogleSignIn gs, FirebaseAuth fa) async {
  await fa.signOut();
  await gs.signOut();
}
