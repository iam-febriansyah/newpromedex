import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:galeri_teknologi_bersama/ui/form_family.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/platform.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FamilyListPage extends StatelessWidget {
  static const routeName = '/familyList_page';

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

                    return ListTile(
                      title: Text(data.nik),
                      subtitle: Text(data.name),
                      trailing: isBookmarked
                          ? IconButton(
                              icon: Icon(MdiIcons.deleteVariant),
                              color: Colors.blue,
                              onPressed: () =>
                                  provider.removeBookmark(data.id.toString()),
                            )
                          : IconButton(
                              icon: Icon(Icons.bookmark_border),
                              color: Theme.of(context).accentColor,
                            ),
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

  // Future<void> _showMyDialog(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Simpan Profil Sebagai'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               TextField(
  //                 decoration: InputDecoration(
  //                     border: OutlineInputBorder(),
  //                     hintText: 'cth:  saya / ayah / adik'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Batal'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Lanjutkan '),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Keluarga',
          style: TextStyle(fontSize: 16, color: Colors.white),
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
                        "Tambah ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(
                        Icons.add,
                        size: 18,
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
          )
        ],
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
