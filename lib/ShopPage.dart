import 'package:Adidas/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'ProductCard.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';


class Shop extends StatefulWidget {

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  Shop(this.googleSignIn,this.auth);
  @override
  _ShopState createState() => new _ShopState();
}

class _ShopState extends State<Shop> {
  


  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: _getPage(currentPage, context, widget.googleSignIn,widget.auth),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.redAccent,
        circleColor: Colors.black,
        inactiveIconColor: Colors.black,
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Home",
          ),
          TabData(iconData: Icons.search, title: "Search"),
          TabData(iconData: Icons.favorite_border, title: "Favorites"),
          TabData(iconData: Icons.shopping_basket, title: "Basket"),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}

_getPage(int page, BuildContext con, GoogleSignIn gs, FirebaseAuth fa) {
  switch (page) {
    case 0:
      return new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 110.0),
                  child: Image.asset(
                    "assets/adidas2.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:70.0),
                  child: IconButton(
                    icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(con, MaterialPageRoute(builder: (con) => ProfilePage(gs,fa)));
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35.0, left: 35.0),
            child: Column(
              children: <Widget>[
                ProductCard(0xFFfaecfb, "assets/2/shoes_01.png",
                    "Hybrid Rocket WNS", "\$999.00", "\$749"),
                SizedBox(
                  height: 32.0,
                ),
                ProductCard(0xFFf8e1da, "assets/2/shoes_02.png",
                    "Hybrid Runner ARS", "\$699", "\$599")
              ],
            ),
          )
        ],
      );
  }
}
