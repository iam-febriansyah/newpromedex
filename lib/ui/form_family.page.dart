import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:galeri_teknologi_bersama/provider/pasien_database.provider.dart';
import 'package:galeri_teknologi_bersama/widget/input_widget.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class FormFamilyPage extends StatefulWidget {
  static const routeName = '/FormFamily_page';

  @override
  _FormFamilyPageState createState() => _FormFamilyPageState();
}

class _FormFamilyPageState extends State<FormFamilyPage> {
  Gender _gender = Gender.male;

  final identityNumber = TextEditingController();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final birthdate = TextEditingController();
  final birthplace = TextEditingController();
  final nationality = TextEditingController();

  String gender = "male";

  bool validationInput() {
    var incorrect = 'please fill correct';
    var isValid = false;

    if (identityNumber.text == null ||
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
        address.text.length < 4) {
      snackBar("$incorrect adress");
    } else if (email.text == null ||
        email.text == "" ||
        email.text.length < 6 ||
        !email.text.contains("@")) {
      snackBar("$incorrect email");
    } else if (birthdate.text == null ||
        birthdate.text == "" ||
        birthdate.text.length < 6) {
      snackBar("$incorrect birthdate");
    } else if (birthplace.text == null ||
        birthplace.text == "" ||
        birthplace.text.length < 4) {
      snackBar("$incorrect birthplace");
    } else {
      isValid = true;
    }

    return isValid;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Isi Data",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 15.0,
                ),
                child: ListView(
                  children: [
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
                                  color: Color.fromRGBO(105, 108, 121, 0.7),
                                )),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 10, right: 10)),
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
                                  color: Color.fromRGBO(105, 108, 121, 0.7),
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
                      controller: email,
                      topLabel: "Email",
                      textInputType: TextInputType.emailAddress,
                      hintText: "Enter your email address",
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
                      height: 15.0,
                    ),
                    InputWidget(
                      controller: nationality,
                      topLabel: "Nationality",
                      textInputType: TextInputType.text,
                      hintText: "Enter your Nationality",
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                )),
          ),
          Consumer<DatabaseProvider>(
            builder: (context, provider, _) {
              return GestureDetector(
                onTap: () {
                  if (validationInput() == true) {
                    Bio bio = new Bio();

                    bio.identityNumber = identityNumber.text;
                    bio.identityParentNumber = "";

                    bio.name = name.text.toUpperCase();
                    bio.gender = gender;
                    bio.birthDay = birthdate.text;
                    bio.birthPlace = birthplace.text;
                    bio.nationality = nationality.text;
                    bio.address = address.text;
                    bio.phone = phoneNumber.text;
                    bio.email = email.text;

                    provider.addBookmark(bio);
                    Navigator.pop(context);
                  }
                },
                child: new Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Simpan",
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
                          colors: [Color(0xFF43b752), Color(0xFF43b752)])),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
