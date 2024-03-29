import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:galeri_teknologi_bersama/common/navigation.dart';
import 'package:galeri_teknologi_bersama/main.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/provider/order_database.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/intro/welcome.dart';
import 'package:galeri_teknologi_bersama/ui/order_history.page.dart';
import 'package:galeri_teknologi_bersama/ui/unused/login.page.dart';
import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
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
  bool isUnauthorized = false;
  bool historyState = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
//  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var displayName = "";
  Timer _timer;

  Timer _timerBiodata;

  _HomePageState() {
    _timer = new Timer(const Duration(milliseconds: 7000), () {
      if (isUnauthorized == true) {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (isUnauthorized == true) Navigation.intentR(Welcome.routeName);
          });
        });
      }
    });
  }

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
              menu01(context),
              history(context),
              //   notifOrder()
            ],
          ),
        ),
      ),
    );
  }

///////////////////////////////////////////////////
  ///
  ///
  Widget notifOrder() {
    return Consumer<DatabaseHistoryOrderProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.HasData) {
          return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.bookmarks.length,
            itemBuilder: (context, index) {
              var data = provider.bookmarks[index];

              return FutureBuilder<bool>(
                  future: provider.isBookmarked(data.id.toString()),
                  builder: (context, snapshot) {
                    var isBookmarked = snapshot.data ?? false;

                    return Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              data.invoiceNumber,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            subtitle: Text(
                              data.vaNumber,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.blueGrey,
                                    letterSpacing: 0.1,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            trailing: isBookmarked
                                ? IconButton(
                                    icon: Icon(FlutterIcons.ios_trash_ion),
                                    color: Colors.black.withOpacity(0.6),
                                    onPressed: () => provider
                                        .removeBookmark(data.id.toString()),
                                  )
                                : IconButton(
                                    icon: Icon(Icons.bookmark_border),
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 0),
                          height: 5,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    );
                  });
            },
          );
        } else if (provider.state == ResultState.NoData) {
          return Center(
              child: Text(
            provider.message,
            textAlign: TextAlign.center,
          ));
        } else if (provider.state == ResultState.Error) {
          return Center(
              child: Text(
            provider.message,
            textAlign: TextAlign.center,
          ));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget history(BuildContext context) {
    if (historyState == true) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, OrderHistory.routeName);
        },
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                  width: 1, color: Colors.white, style: BorderStyle.solid)),
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              FlutterIcons.book_ent,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Riwayat Pemesanan ",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 25,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.chevron_right),
              ),
            )
          ]),
        ),
      );
    } else {
      return Text("");
    }
  }

///////////////////////////////////////////////////////////////////////////////

  Widget profilnotifbar(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        provider.getName;
        provider.getEmail;
        provider.getPhone;

        displayName = provider.name;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // if (provider.isLogin != false) {
                //   Navigator.pushNamed(context, ProfilePage.routeName);
                // } else {
                //   Navigator.pushNamed(context, LoginRegister.routeName);
                // }
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
                          color: Colors.blueGrey,
                          letterSpacing: 0.1,
                          fontSize: 18,
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
                backgroundColor: Color(0xFF43b752),
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
    return Consumer<MenuProvider>(builder: (context, provider, _) {
      if (provider.stateMenu == ResultState.Loading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshProgressIndicator(),
          ),
        );
      } else if (provider.stateMenu == ResultState.HasData) {
        if (historyState == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              historyState = true;
            });
          });
        }
        var data = provider.responseMenu;
        return GridView.builder(
            shrinkWrap: true,
            primary: false, // agar bisa scrool listview

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: data.menus.length,
            itemBuilder: (BuildContext context, int index) {
              return CardHome(
                itemID: data.menus[index].itemId.toString(),
                itemName: data.menus[index].itemName,
                tag: data.menus[index].tag,
                collect: data.menus[index].collect,
                image: data.menus[index].image,
              );
            });
      } else if (provider.stateMenu == ResultState.NoData) {
        return Center(
            child: Text(
          provider.messageMenu,
          textAlign: TextAlign.center,
        ));
      } else if (provider.stateMenu == ResultState.Warning) {
        isUnauthorized = true;
        return Center(child: Text(''));
      } else if (provider.stateMenu == ResultState.Error) {
        return Center(
            child: Text(
          provider.messageMenu,
          textAlign: TextAlign.center,
        ));
      } else {
        return Center(child: Text(''));
      }
    });
  }

  // Widget menu01(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: firestore.collection("menu1").snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Padding(
  //           padding: const EdgeInsets.only(top: 50),
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       } else {
  //         List<dynamic> response = snapshot.data.docs;
  //         return GridView.builder(
  //             shrinkWrap: true,
  //             primary: false, // agar bisa scrool listview

  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 3,
  //             ),
  //             itemCount: response.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return CardHome(
  //                 itemID: response[index]['itemID'],
  //                 itemName: response[index]['itemName'],
  //                 tag: response[index]['tag'],
  //                 collect: response[index]['collect'],
  //                 image: response[index]['image'],
  //               );
  //             });
  //       }
  //     },
  //   );
  // }

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
                        backgroundColor: Color(0xFF43b752),
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
