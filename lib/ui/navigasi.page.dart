import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:galeri_teknologi_bersama/main.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/home.page.dart';
import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:galeri_teknologi_bersama/ui/unused/switch.page.dart';
import 'package:galeri_teknologi_bersama/widget/platform.widget.dart';
import 'package:provider/provider.dart';

class NavPage extends StatefulWidget {
  static const routeName = '/nav_page';
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          NavPage.routeName,
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, NavPage.routeName);
    });
  }

  List<Widget> listWidget = [
    HomePage(),
    HomePage(),
    HomePage(),
    ProfilePage(),
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF43b752), Color(0xFF43b752)])),
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
