import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/ui/unused/login_phone.page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginRegister extends StatefulWidget {
  static const routeName = '/loginregister_page';

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterbuild(context));
  }

  void afterbuild(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    provider.currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(
                "assets/sehat.png",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AuthPhonePage.routeName);
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF207ce5), Color(0xFF0c92f1)])),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                          height:
                              (MediaQuery.of(context).size.height * 0.4) / 5,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Login/Register with phone",
                                    style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.1,
                                        fontSize: 15,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          height:
                              (MediaQuery.of(context).size.height * 0.4) / 5,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Login/Register with email",
                                    style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.1,
                                        fontSize: 15,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    ));
  }
}
