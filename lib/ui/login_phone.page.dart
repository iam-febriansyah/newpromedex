import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/ui/login_phone_verif.page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthPhonePage extends StatefulWidget {
  static const routeName = '/PhoneNumber_page';

  AuthPhonePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AuthPhonePageState createState() => _AuthPhonePageState();
}

class _AuthPhonePageState extends State<AuthPhonePage> {
  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _phoneNumberController = TextEditingController();

  final SmsAutoFill _autoFill = SmsAutoFill();

  int phoneNumber = 0;

  Future autofill() async {
    _phoneNumberController.text = await _autoFill.hint;
    return Future.error('Terjadi kesalahan');
  }

  @override
  Widget build(BuildContext context) {
    _phoneNumberController.text = "+62";
    _phoneNumberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneNumberController.text.length));

    if (phoneNumber == 0) {
      autofill();
      setState(() {
        phoneNumber = 1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Verify your phone number",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                            color: Colors.white60,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid),
                          ),
                          child: TextFormField(
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            keyboardType: TextInputType.number,
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5),
                                labelText: '',
                                isCollapsed: true,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50, top: 50, bottom: 50),
                        child: Container(
                          transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              _phoneNumberController.text = "+62";
                              _phoneNumberController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          _phoneNumberController.text.length));
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                if (_phoneNumberController.text.length > 10) {
                  Navigator.pushReplacementNamed(
                    context,
                    AuthPhoneVerifPage.routeName,
                    arguments: _phoneNumberController.text,
                  );
                } else {
                  snackBar("nomor hp tidak valid");
                }
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF207ce5), Color(0xFF0c92f1)])),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
