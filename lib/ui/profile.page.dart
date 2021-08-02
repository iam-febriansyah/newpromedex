import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/ui/family.page.dart';

import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var name = "";
  var email = "";
  var phone = "";

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => afterbuild(context));
  }

  // void afterbuild(BuildContext context) {
  //   var provider =
  //       Provider.of<BottomNavigationBarProvider>(context, listen: false);
  //   provider.currentIndex = 0;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        name = provider.name;
        email = provider.email;
        phone = provider.phone;

        return ListView(
          children: [
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Material(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  //dialogUsername(context);
                },
                child: ListTile(
                    title: Text('Name'),
                    subtitle: Text(name),
                    trailing: IconButton(
                        icon: Icon((MdiIcons.chevronRight)), onPressed: () {})),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Material(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  //dialogUsername(context);
                },
                child: ListTile(
                    title: Text('Phone'),
                    subtitle: Text(phone),
                    trailing: IconButton(
                        icon: Icon((MdiIcons.chevronRight)), onPressed: () {})),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Material(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  //dialogUsername(context);
                },
                child: ListTile(
                    title: Text('Email'),
                    subtitle: Text(email),
                    trailing: IconButton(
                        icon: Icon((MdiIcons.chevronRight)), onPressed: () {})),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Material(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ListFamilyPage.routeName);
                },
                child: ListTile(
                    title: Text('Data Keluarga'),
                    subtitle: Text(""),
                    trailing: IconButton(
                        icon: Icon((MdiIcons.chevronRight)), onPressed: () {})),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Material(
              color: Colors.white,
              child: GestureDetector(
                  onTap: () async {
                    provider.setAccesToken("kosong");

                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Logout'),
                  )),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  void logout(BuildContext context) {
    try {
      _auth.signOut();
      snackBar("Successfully logout", context);
    } catch (e) {
      print(e);
      snackBar("Failed logout", context);
    }
  }

  snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
