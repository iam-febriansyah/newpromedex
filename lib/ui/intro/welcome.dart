import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galeri_teknologi_bersama/ui/intro/login.dart';
import 'package:galeri_teknologi_bersama/ui/intro/register.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:galeri_teknologi_bersama/common/navigation.dart';

class Welcome extends StatelessWidget {
  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Use [SystemUiOverlayStyle.light] for white status bar
      // or [SystemUiOverlayStyle.dark] for black status bar
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF43b752), // Color(0xFF0c92f1),
        systemNavigationBarColor: Color(0xfffafaff), // navigation bar color
        statusBarIconBrightness: Brightness.dark, // st
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF43b752),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 100.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/cloth_faded.png"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Image.asset(
                          "assets/images/dokter.png",
                          scale: 1.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 24.0,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeData.light().scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20.0),
                      Text(
                        "Welcome to Promedex!",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(19, 22, 33, 1),
                            ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "This is the first version of our Promedex app. Please sign in or create an account below.",
                        style: TextStyle(
                          color: Color.fromRGBO(74, 77, 84, 1),
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      // Let's create a generic button widget
                      Expanded(
                        child: AppButton(
                          text: "Log In",
                          type: ButtonType.PLAIN,
                          onPressed: () {
                            Navigation.intent(Login.routeName);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: AppButton(
                          text: "Create an Account",
                          type: ButtonType.PRIMARY,
                          onPressed: () {
                            Navigation.intent(Register.routeName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
