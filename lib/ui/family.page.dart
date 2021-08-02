import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:galeri_teknologi_bersama/ui/form_family.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_payment.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/platform.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ListFamilyPage extends StatefulWidget {
  static const routeName = '/ListFamily_page';

  const ListFamilyPage({Key key}) : super(key: key);

  @override
  _ListFamilyPageState createState() => _ListFamilyPageState();
}

class _ListFamilyPageState extends State<ListFamilyPage> {
  Widget _buildList() {
    return Consumer<DatabaseProvider>(
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
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data.name,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data.identityNumber,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.blueGrey,
                                      letterSpacing: 0.1,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
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

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xfffafaff), // Color(0xFF0c92f1),
          systemNavigationBarColor: Color(0xfffafaff), // navigation bar color
          statusBarIconBrightness: Brightness.dark), // st
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Data Keluarga',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FormFamilyPage.routeName);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Tambah   ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.1,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(
                          FlutterIcons.adduser_ant,
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(child: _buildList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }
}
