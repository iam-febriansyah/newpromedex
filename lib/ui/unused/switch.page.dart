import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/firebase.provider.dart';

import 'package:galeri_teknologi_bersama/ui/unused/login.page.dart';

import 'package:galeri_teknologi_bersama/ui/profile.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

import 'package:provider/provider.dart';

class SwitchPage extends StatefulWidget {
  static const routeName = '/switch_page';

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterbuild(context));
  }

  void afterbuild(BuildContext context) {
    if (isLogin == true) {
      Navigator.pushNamed(
        context,
        ProfilePage.routeName,
      );
    } else {
      Navigator.pushNamed(
        context,
        LoginRegister.routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, provider, _) {
        provider.fetchdataUser;

        if (provider.state == ResultState.HasData) {
          isLogin = true;
        } else {
          isLogin = false;
        }

        return Center();
      },
    );
  }
}
