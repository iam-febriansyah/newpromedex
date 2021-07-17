import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/ui/home.page.dart';
import 'package:galeri_teknologi_bersama/ui/login.page.dart';
import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:galeri_teknologi_bersama/ui/switch.page.dart';

import 'package:galeri_teknologi_bersama/widget/platform.widget.dart';

import 'package:provider/provider.dart';

class NavPage extends StatefulWidget {
  static const routeName = '/nav_page';
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  List<Widget> listWidget = [
    HomePage(),
    HomePage(),
    HomePage(),
    SwitchPage(),

    //   Navigator.pushNamed(context, ProfilePage);
  ];

  Widget buildAndroid(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    provider.bottomNavBarItems(provider.currentIndex);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Use [SystemUiOverlayStyle.light] for white status bar
      // or [SystemUiOverlayStyle.dark] for black status bar
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xfffafaff), // Color(0xFF0c92f1),
        systemNavigationBarColor: Color(0xfffafaff), // navigation bar color
        statusBarIconBrightness: Brightness.dark, // st
      ),
      child: Scaffold(
        body: listWidget[provider.currentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF207ce5), Color(0xFF0c92f1)])),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 16),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              currentIndex: provider.currentIndex,
              items: provider.bottomnav,
              onTap: (index) {
                provider.currentIndex = index;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIos(BuildContext context) {
    return CupertinoTabScaffold();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: buildAndroid,
      iosBuilder: buildAndroid,
    );
  }
}
