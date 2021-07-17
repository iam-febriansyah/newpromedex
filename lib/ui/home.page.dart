import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/ui/login.page.dart';
import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:galeri_teknologi_bersama/utils/datadummy.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/cardhome.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: profilnotifbar(context),
              ),
              Padding(padding: EdgeInsets.all(20)),
              search(context),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: title1(context)),
              // Container(
              //     margin: const EdgeInsets.only(left: 10, right: 10),
              //     child: menu1(context)),
              menu01(context)
            ],
          ),
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////

  Widget profilnotifbar(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, provider, _) {
        provider.fetchisLogin;
        provider.fetchdataUser;

        var displayName;

        if (provider.state == ResultState.HasData) {
          displayName = provider.userData.phoneNumber;
        } else {
          displayName = "Login/Register";
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (provider.isLogin != false) {
                  Navigator.pushNamed(context, ProfilePage.routeName);
                } else {
                  Navigator.pushNamed(context, LoginRegister.routeName);
                }
              },
              child: Row(
                children: [
                  Container(
                    height: 45.0,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/man.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      displayName,
                      style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                          color: Colors.blue,
                          letterSpacing: 0.1,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.0,
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/notification.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget title1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "What do you need ?",
            style: GoogleFonts.mukta(
              textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget menu01(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection("menu1").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          List<dynamic> response = snapshot.data.docs;
          return GridView.builder(
              shrinkWrap: true,
              primary: false, // agar bisa scrool listview

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: response.length,
              itemBuilder: (BuildContext context, int index) {
                return CardHome(
                  itemID: response[index]['itemID'],
                  itemName: response[index]['itemName'],
                  tag: response[index]['tag'],
                  collect: response[index]['collect'],
                  image: response[index]['image'],
                );
              });
        }
      },
    );
  }

  Widget menu1(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false, // agar bisa scrool listview

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: layanan.length,
        itemBuilder: (BuildContext context, int index) {
          return CardHome(
            itemName: layanan[index]['name'],
            image: layanan[index]['url'],
            collect: layanan[index]['collection'],
          );
        });
  }

  Widget search(BuildContext context) {
    var preferenceProvider = Provider.of<PreferencesProvider>(context);
    Color myColorsText =
        preferenceProvider.isDarkTheme ? Colors.white : Colors.black;
    Color myColorsBox =
        preferenceProvider.isDarkTheme ? Colors.white : Colors.white;
    return Consumer<PreferencesProvider>(builder: (context, provider, _) {
      return Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: myColorsBox,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                      width: 1,
                      color: Color(0xfffafaff),
                      style: BorderStyle.solid),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                            hintText: 'Search for poly',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            contentPadding: EdgeInsets.only(
                                top: 15, right: 7, bottom: 15, left: 10),
                            isCollapsed: true,
                            border: InputBorder.none),
                        onChanged: (value) {
                          if (value != null && value.length > 0) {
                            // provider.query = value;
                            //   _debouncer
                            //     .run(() => provider.fetchSearchOfRestaurant);
                            //  print('First text field: $value ');
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 35.0,
                      child: FloatingActionButton(
                        heroTag: "btn3",
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/search.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
