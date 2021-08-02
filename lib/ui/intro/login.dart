import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:galeri_teknologi_bersama/common/navigation.dart';
import 'package:galeri_teknologi_bersama/data/model/request/login.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/login.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:galeri_teknologi_bersama/widget/input_widget.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  final username = TextEditingController();
  final password = TextEditingController();

  RequestLogin requestLogin() {
    RequestLogin requestLogin = new RequestLogin();
    requestLogin.username = username.text;
    requestLogin.password = password.text;
    return requestLogin;
  }

  @override
  Widget build(BuildContext context) {
    var providerLogin = Provider.of<LoginProvider>(context);
    var providerMenu = Provider.of<MenuProvider>(context);
    var providerUser = Provider.of<PreferencesProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    "assets/images/washing.png",
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                FlutterIcons.keyboard_backspace_mdi,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Log in to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              InputWidget(
                                controller: username,
                                topLabel: "Username",
                                textInputType: TextInputType.text,
                                hintText: "Enter your username",
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              InputWidget(
                                topLabel: "Password",
                                textInputType: TextInputType.text,
                                controller: password,
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Consumer<LoginProvider>(
                                  builder: (context, provider, _) {
                                if (provider.state == ResultState.Loading) {
                                  return Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: RefreshProgressIndicator(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Color(0xFF33508a))),
                                    ),
                                  );
                                } else {
                                  return Padding(padding: EdgeInsets.all(0));
                                }
                              }),

                              AppButton(
                                type: ButtonType.PRIMARY,
                                text: "Log In",
                                onPressed: () async {
                                  providerLogin.setLogin(requestLogin());
                                  await providerLogin.fetch;
                                  if (providerLogin.state ==
                                      ResultState.HasData) {
                                    await providerMenu.fetchMenu;
                                    await providerMenu.fetchTokenFcm;
                                    Navigation.intentR(
                                      NavPage.routeName,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
