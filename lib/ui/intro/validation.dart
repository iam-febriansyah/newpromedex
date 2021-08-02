// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:galeri_teknologi_bersama/common/navigation.dart';
// import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
// import 'package:galeri_teknologi_bersama/data/model/response/login.dart';
// import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
// import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
// import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
// import 'package:galeri_teknologi_bersama/ui/intro/welcome.dart';
// import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
// import 'package:galeri_teknologi_bersama/utils/result_state.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Validation extends StatefulWidget {
//   static const routeName = '/validation';

//   @override
//   _ValidationState createState() => _ValidationState();
// }

// class _ValidationState extends State<Validation> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MenuProvider>(builder: (context, provider, _) {
//       if (provider.state == ResultState.Loading) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (provider.state == ResultState.HasData) {
//         print("HasData");

//         WidgetsBinding.instance
//             .addPostFrameCallback((_) => Navigation.intentR(NavPage.routeName));
//         return Padding(padding: EdgeInsets.all(0));
//       } else {
//         print("else");
//         WidgetsBinding.instance
//             .addPostFrameCallback((_) => Navigation.intentR(Welcome.routeName));
//         return Padding(padding: EdgeInsets.all(0));
//       }
//     });
//   }
// }
