import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:galeri_teknologi_bersama/ui/form_family.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_payment.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/platform.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class OrderProfilPage extends StatefulWidget {
  static const routeName = '/orderProfil_page';
  final DataOrder dataOrder;

  const OrderProfilPage({Key key, this.dataOrder}) : super(key: key);

  @override
  _OrderProfilPageState createState() => _OrderProfilPageState();
}

class _OrderProfilPageState extends State<OrderProfilPage> {
  // ignore: deprecated_member_use
  List<Bio> bio = new List<Bio>();
  // ignore: deprecated_member_use
  List<bool> checkBox = new List<bool>();

  DataOrder _dataOrder = new DataOrder();

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
              checkBox.add(false);

              return FutureBuilder<bool>(
                  future: provider.isBookmarked(data.id.toString()),
                  builder: (context, snapshot) {
                    var isBookmarked = snapshot.data ?? false;

                    return ListTile(
                      leading: Checkbox(
                        activeColor: Colors.blue,
                        value: checkBox[
                            index], //data.isChecked == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            // data.isChecked = value == false ? 0 : 1;
                            checkBox[index] = value == false ? false : true;
                            if (value == true) {
                              bio.add(data);
                            } else {
                              bio.removeWhere((item) => item.id == data.id);
                            }
                            print(bio);
                          });
                        },
                      ),
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
    _dataOrder = widget.dataOrder;
    // print(_dataOrder.date + " " + _dataOrder.hours + " " + _dataOrder.nameItem);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xfffafaff), // Color(0xFF0c92f1),
          systemNavigationBarColor: Color(0xfffafaff), // navigation bar color
          statusBarIconBrightness: Brightness.dark), // st
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Data Reservasi',
            style: TextStyle(fontSize: 17, color: Colors.white),
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
            ),
            GestureDetector(
              onTap: () {
                if (bio.length == 0) {
                  snackBar('profil reservasi belum dipilih');
                } else {
                  _dataOrder.profilPasien = bio;
                  _dataOrder.quantity = bio.length;

                  Navigator.pushNamed(context, PaymentMethode.routeName,
                      arguments: _dataOrder);
                }
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Lanjutkan",
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
