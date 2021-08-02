import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:galeri_teknologi_bersama/data/model/request/register.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/register.provider.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:galeri_teknologi_bersama/widget/input_widget.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class Register extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Gender _gender = Gender.male;

  final username = TextEditingController();
  final identityNumber = TextEditingController();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final birthdate = TextEditingController();
  final birthplace = TextEditingController();
  String gender = "male";

  void clearController() {
    username.text = "";
    identityNumber.text = "";
    name.text = "";
    phoneNumber.text = "";
    address.text = "";
    email.text = "";
    password.text = "";
    birthdate.text = "";
    birthplace.text = "";
  }

  bool validationInput() {
    var incorrect = 'please fill correct';
    var isValid = false;

    if (username.text == null ||
        username.text == "" ||
        username.text.length < 3) {
      snackBar("$incorrect username");
    } else if (identityNumber.text == null ||
        identityNumber.text == "" ||
        identityNumber.text.length < 5) {
      snackBar("$incorrect identityNumber");
    } else if (name.text == null || name.text == "" || name.text.length < 3) {
      snackBar("$incorrect correct name");
    } else if (phoneNumber.text == null ||
        phoneNumber.text == "" ||
        phoneNumber.text.length < 10) {
      snackBar("$incorrect phone number");
    } else if (address.text == null ||
        address.text == "" ||
        address.text.length < 5) {
      snackBar("$incorrect adress");
    } else if (email.text == null ||
        email.text == "" ||
        email.text.length < 6 ||
        !email.text.contains("@")) {
      snackBar("$incorrect email");
    } else if (password.text == null ||
        password.text == "" ||
        password.text.length < 6) {
      snackBar("$incorrect password");
    } else if (birthdate.text == null ||
        birthdate.text == "" ||
        birthdate.text.length < 6) {
      snackBar("$incorrect birthdate");
    } else if (birthplace.text == null ||
        birthplace.text == "" ||
        birthplace.text.length < 6) {
      snackBar("$incorrect birthplace");
    } else {
      isValid = true;
    }

    return isValid;
  }

  RequestRegister addRequestRegister() {
    RequestRegister requestRegister = new RequestRegister();
    requestRegister.username = username.text;
    requestRegister.phone = phoneNumber.text;
    requestRegister.email = email.text;
    requestRegister.name = name.text;

    requestRegister.birthDay = birthdate.text;
    requestRegister.birthPlace = birthplace.text;
    requestRegister.address = address.text;
    requestRegister.email = email.text;
    requestRegister.password = password.text;
    requestRegister.identityNumber = identityNumber.text;
    requestRegister.gender = gender;

    return requestRegister;
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerRegister = Provider.of<RegisterProvider>(context);

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
                              "Register and become our client",
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
                                height: 15.0,
                              ),

                              InputWidget(
                                controller: email,
                                topLabel: "Email",
                                textInputType: TextInputType.emailAddress,
                                hintText: "Enter your email address",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                topLabel: "Password",
                                controller: password,
                                textInputType: TextInputType.text,
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                controller: identityNumber,
                                topLabel: "Identity Number",
                                textInputType: TextInputType.text,
                                hintText: "Enter your identity number",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                controller: name,
                                topLabel: "Name",
                                textInputType: TextInputType.text,
                                hintText: "Enter your name",
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                              Text("Gender"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio<Gender>(
                                        activeColor: Color(0xFF33508a),
                                        value: Gender.male,
                                        groupValue: _gender,
                                        onChanged: (Gender value) {
                                          setState(() {
                                            _gender = value;
                                            gender = "male";
                                          });
                                        },
                                      ),
                                      Icon(
                                        FlutterIcons.male_faw,
                                      ),
                                      Text(" Male",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                105, 108, 121, 0.7),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10)),
                                  Row(
                                    children: [
                                      Radio<Gender>(
                                        activeColor: Color(0xFF33508a),
                                        value: Gender.female,
                                        groupValue: _gender,
                                        onChanged: (Gender value) {
                                          setState(() {
                                            _gender = value;
                                            gender = "female";
                                          });
                                        },
                                      ),
                                      Icon(
                                        FlutterIcons.female_faw,
                                      ),
                                      Text(" Female",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                105, 108, 121, 0.7),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidgetDate(
                                controller: birthdate,
                                topLabel: "Birthday",
                                hintText: "Enter your birthday",
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                controller: birthplace,
                                topLabel: "Birth Place",
                                textInputType: TextInputType.text,
                                hintText: "Enter your birth place",
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                controller: phoneNumber,
                                topLabel: "Phone",
                                textInputType: TextInputType.number,
                                hintText: "Enter your phone number",
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                              InputWidget(
                                controller: address,
                                topLabel: "Address",
                                textInputType: TextInputType.text,
                                hintText: "Enter your address",
                              ),

                              SizedBox(
                                height: 25.0,
                              ),

                              Consumer<RegisterProvider>(
                                  builder: (context, provider, _) {
                                if (provider.state == ResultState.Loading) {
                                  return Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: RefreshProgressIndicator(),
                                    ),
                                  );
                                } else if (provider.state ==
                                        ResultState.HasData &&
                                    provider.btnRegister == true) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    snackBar("Registrasi " +
                                        provider.responseRegister.message);
                                    if (provider.responseRegister.statusCode ==
                                        200) clearController();
                                  });
                                  provider.setBtnRegister(false);
                                  return Text("");
                                } else {
                                  provider.setBtnRegister(false);
                                  return Text("");
                                }
                              }),

                              AppButton(
                                type: ButtonType.PRIMARY,
                                text: "Register",
                                onPressed: () {
                                  if (validationInput() == true &&
                                      providerRegister.btnRegister == false) {
                                    providerRegister.setBtnRegister(true);
                                    var register = addRequestRegister();
                                    providerRegister.setRegister(register);
                                    providerRegister.fetch;
                                  }
                                },
                              )
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
