import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/common/navigation.dart';
import 'package:galeri_teknologi_bersama/data/local/bio.sqlite.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/data/model/merchant.dart';
import 'package:galeri_teknologi_bersama/data/local/theme.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';
import 'package:galeri_teknologi_bersama/data/remote/firebase.service.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab.service.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/provider/payment.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/trash/auth.page';
import 'package:galeri_teknologi_bersama/ui/book.page.dart';
import 'package:galeri_teknologi_bersama/ui/family.page.dart';
import 'package:galeri_teknologi_bersama/ui/form_family.page.dart';
import 'package:galeri_teknologi_bersama/ui/login.page.dart';
import 'package:galeri_teknologi_bersama/ui/login_phone.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_completed.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_profil.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_payment.page.dart';
import 'package:galeri_teknologi_bersama/ui/switch.page.dart';
//import 'package:galeri_teknologi_bersama/ui/authphone.page.dart';
import 'package:galeri_teknologi_bersama/ui/login_phone_verif.page.dart';
import 'package:galeri_teknologi_bersama/ui/service.page.dart';
import 'package:galeri_teknologi_bersama/ui/merchant.page.dart';
import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PaymentProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                themePreference: ThemePreference(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                FirebaseProvider(firebaseService: FirebaseService())),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hehe',
          theme: provider.themeData,
          navigatorKey: navigatorKey,
          initialRoute: NavPage.routeName, //NavPage.routeName,
          routes: {
            NavPage.routeName: (context) => NavPage(),
            LoginRegister.routeName: (context) => LoginRegister(),
            ProfilePage.routeName: (context) => ProfilePage(),
            SwitchPage.routeName: (context) => SwitchPage(),
            FamilyListPage.routeName: (context) => FamilyListPage(),
            FormFamilyPage.routeName: (context) => FormFamilyPage(),

            OrderProfilPage.routeName: (context) => OrderProfilPage(
                  dataOrder:
                      ModalRoute.of(context).settings.arguments as DataOrder,
                ),
            PaymentMethode.routeName: (context) => PaymentMethode(
                dataOrder:
                    ModalRoute.of(context).settings.arguments as DataOrder),
            PaymentCompleted.routeName: (context) => PaymentCompleted(
                paymentResponse: ModalRoute.of(context).settings.arguments
                    as PaymentResponse),

            BookPage.routeName: (context) => BookPage(
                  merchant:
                      ModalRoute.of(context).settings.arguments as Merchant,
                ),

            //AuthPage.routeName: (context) => AuthPage(),
            AuthPhonePage.routeName: (context) => AuthPhonePage(),
            AuthPhoneVerifPage.routeName: (context) => AuthPhoneVerifPage(
                phoneNumber:
                    ModalRoute.of(context).settings.arguments as String),

            MerchantPage.routeName: (context) => MerchantPage(
                data:
                    ModalRoute.of(context).settings.arguments as List<String>),
            LayananPage.routeName: (context) => LayananPage(
                data: ModalRoute.of(context).settings.arguments as Merchant),
          },
        );
      }),
    );
  }
}
