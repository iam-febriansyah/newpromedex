import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:galeri_teknologi_bersama/data/model/historyorder.dart';
import 'package:galeri_teknologi_bersama/data/model/historyorderhomecare.dart';
import 'package:galeri_teknologi_bersama/data/model/myorder.dart';

import 'package:galeri_teknologi_bersama/main.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/order_database.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
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
  bool swabber = false;
  // MyOrder myOrder;

  HistoryOrder historyOrder;
  HistoryOrderHomeCare historyOrderHomeCare;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
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

      historyOrder = new HistoryOrder();
      print(" Navigasi Page =========== from onMessage.listen");
      print(message.notification.title);
      debugPrint(message.data.toString(), wrapWidth: 1024);

      if (message.data['vaNumber'] != null) {
        if (mounted) {
          setState(() {
            historyOrder.channel = message.data['channel'];
            historyOrder.clientId = message.data['clientId'];
            historyOrder.expiredTime = message.data['expiredTime'];
            historyOrder.invoiceNumber = message.data['invoiceNumber'];
            historyOrder.status = message.data['status'];
            historyOrder.totalPrice = message.data['totalPrice'];
            historyOrder.vaNumber = message.data['vaNumber'];
            swabber = true;
            print(historyOrder.vaNumber + "Va  number");
          });
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      historyOrder = new HistoryOrder();
      print(" Navigasi Page =========== from onMessageOpenedApp.listen");
      print(message.notification.title);
      debugPrint(message.data.toString(), wrapWidth: 1024);

      if (message.data['vaNumber'] != null) {
        if (mounted) {
          setState(() {
            historyOrder.channel = message.data['channel'];
            historyOrder.clientId = message.data['clientId'];
            historyOrder.expiredTime = message.data['expiredTime'];
            historyOrder.invoiceNumber = message.data['invoiceNumber'];
            historyOrder.status = message.data['status'];
            historyOrder.totalPrice = message.data['totalPrice'];
            historyOrder.vaNumber = message.data['vaNumber'];
            swabber = true;
            print(historyOrder.vaNumber + "Va  number");
          });
        }
      }
    });
  }

  List<Widget> listWidget = [
    HomePage(),
    HomePage(),
    HomePage(),
    ProfilePage(),
  ];

  Widget buildAndroid(BuildContext context) {
    historyOrderHomeCare = new HistoryOrderHomeCare();

    var provider = Provider.of<BottomNavigationBarProvider>(context);
    var providerMenu = Provider.of<MenuProvider>(context);

    var providerPayment = Provider.of<PaymentProvider>(context);

    provider.bottomNavBarItems(provider.currentIndex);

    var providerHistoryOrder =
        Provider.of<DatabaseHistoryOrderProvider>(context);

    if (swabber == true) {
      Future.delayed(Duration.zero, () {
        print(historyOrder.invoiceNumber);
        providerPayment.setInvoice(historyOrder.invoiceNumber);

        print("dari notif " + historyOrder.invoiceNumber);
        providerPayment.fetchinvoicehomecare;
        providerPayment.responseInvoiceHomeCare;

        setState(() {
          if (providerPayment.responseInvoiceHomeCare != null) {
            // historyOrderHomeCare.idswabber = "55";

            // historyOrderHomeCare.vaNumber = "1291920129";

            // historyOrderHomeCare.expiredTime = "12/01/1990";

            // historyOrderHomeCare.totalPrice = 3144641;

            // historyOrderHomeCare.channel = "BCA";

            print("dari response invoice " +
                providerPayment
                    .responseInvoiceHomeCare.dataReservation.invoiceNumber);

            historyOrderHomeCare.invoiceNumber = providerPayment
                .responseInvoiceHomeCare.dataReservation.invoiceNumber;
            historyOrderHomeCare.idswabber =
                providerPayment.responseInvoiceHomeCare.dataSwabber.id;

            historyOrderHomeCare.vaNumber =
                providerPayment.responseInvoiceHomeCare.dataPayment.vaNumber;

            historyOrderHomeCare.expiredTime = providerPayment
                .responseInvoiceHomeCare.dataPayment.expiredTime
                .toString();

            historyOrderHomeCare.totalPrice =
                providerPayment.responseInvoiceHomeCare.dataPayment.totalPrice;
            historyOrderHomeCare.channel =
                providerPayment.responseInvoiceHomeCare.dataPayment.channel;
            // }

            // swabber = false;
            providerHistoryOrder.addBookmark(historyOrderHomeCare);
            providerMenu.fetchListSwabber;
            swabber = false;
          }
        });
      });
    }

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
