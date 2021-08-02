import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/common/navigation.dart';
import 'package:galeri_teknologi_bersama/data/local/bio.sqlite.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';

import 'package:galeri_teknologi_bersama/data/local/theme.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';
import 'package:galeri_teknologi_bersama/data/model/response/login.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';
import 'package:galeri_teknologi_bersama/data/remote/firebase.service.dart';
import 'package:galeri_teknologi_bersama/ui/order_track_location.dart';
import 'package:galeri_teknologi_bersama/ui/unused/speedlab.service.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/login.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/register.provider.dart';
import 'package:galeri_teknologi_bersama/trash/auth.page';
import 'package:galeri_teknologi_bersama/ui/book.page.dart';
import 'package:galeri_teknologi_bersama/ui/family.page.dart';
import 'package:galeri_teknologi_bersama/ui/form_family.page.dart';
import 'package:galeri_teknologi_bersama/ui/intro/login.dart';
import 'package:galeri_teknologi_bersama/ui/intro/validation.dart';
import 'package:galeri_teknologi_bersama/ui/order_location_user.page.dart';
import 'package:galeri_teknologi_bersama/ui/unused/fcm.dart';
import 'package:galeri_teknologi_bersama/ui/unused/login.page.dart';
import 'package:galeri_teknologi_bersama/ui/unused/login_phone.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_completed.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_profil.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_payment.page.dart';
import 'package:galeri_teknologi_bersama/ui/intro/register.dart';
import 'package:galeri_teknologi_bersama/ui/unused/switch.page.dart';
//import 'package:galeri_teknologi_bersama/ui/authphone.page.dart';
import 'package:galeri_teknologi_bersama/ui/unused/login_phone_verif.page.dart';
import 'package:galeri_teknologi_bersama/ui/service.page.dart';
import 'package:galeri_teknologi_bersama/ui/merchant.page.dart';
import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:galeri_teknologi_bersama/ui/intro/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.notification.title}');
  print('Handling a background message ${message.notification.body}');

  print('Handling a background message ${message.data}');

  print(message.data);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(devService: DevService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(devService: DevService()),
        ),
        ChangeNotifierProvider(
          create: (_) => MenuProvider(devService: DevService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentProvider(devService: DevService()),
        ),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                themePreference: ThemePreference(
                    sharedPreferences: SharedPreferences.getInstance()),
                userPreference: UserPreference(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        // ChangeNotifierProvider(
        //     create: (_) =>
        //         FirebaseProvider(firebaseService: FirebaseService())

        //         ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hehe',
          theme: provider.themeData,
          navigatorKey: navigatorKey,
          initialRoute: NavPage.routeName, //NavPage.routeName,
          routes: {
            LalaSwitchPage.routeName: (context) => LalaSwitchPage(),

            //
            Welcome.routeName: (context) => Welcome(),
            Login.routeName: (context) => Login(),
            Register.routeName: (context) => Register(),
            NavPage.routeName: (context) => NavPage(),
            ProfilePage.routeName: (context) => ProfilePage(),
            ListFamilyPage.routeName: (context) => ListFamilyPage(),

            ///=== Home Care Flow
            LocationUserPage.routeName: (context) => LocationUserPage(
                  merchant:
                      ModalRoute.of(context).settings.arguments as Merchant,
                ),

            PaymentTrack.routeName: (context) => PaymentTrack(),

            ///===?
            MerchantPage.routeName: (context) => MerchantPage(
                data:
                    ModalRoute.of(context).settings.arguments as List<String>),
            LayananPage.routeName: (context) => LayananPage(
                data: ModalRoute.of(context).settings.arguments as Merchant),

            BookPage.routeName: (context) => BookPage(
                  merchant:
                      ModalRoute.of(context).settings.arguments as Merchant,
                ),

            OrderProfilPage.routeName: (context) => OrderProfilPage(
                  dataOrder:
                      ModalRoute.of(context).settings.arguments as DataOrder,
                ),

            FormFamilyPage.routeName: (context) => FormFamilyPage(),

            PaymentMethode.routeName: (context) => PaymentMethode(
                dataOrder:
                    ModalRoute.of(context).settings.arguments as DataOrder),

            PaymentCompleted.routeName: (context) => PaymentCompleted(),
          },
        );
      }),
    );
  }
}
