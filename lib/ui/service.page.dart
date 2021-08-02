import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/book.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_location_user.page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LayananPage extends StatelessWidget {
  static const routeName = '/service_page';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Merchant data;
  LayananPage({this.data});
  final oCcy = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    //List<dynamic> layanan = data[0];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            data.itemName,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        body: Consumer<MenuProvider>(builder: (context, provider, _) {
          return SafeArea(
              child: ListView.builder(
            itemCount: data.service.length,
            itemBuilder: (context, index) {
              int i = 0;
              if (data.service[index].tag.contains(provider.tagFilter)) {
                // i++;
                // print("tagMenu : " +
                //     provider.tagFilter +
                //     ", "
                //         "tagService : " +
                //     data.service[index].tag +
                //     ", show : " +
                //     i.toString());

                return GestureDetector(
                  onTap: () {
                    data.serviceClick = index;

                    if (provider.tagFilter.contains("homecare")) {
                      Navigator.pushNamed(context, LocationUserPage.routeName,
                          arguments: data);
                    } else {
                      Navigator.pushNamed(context, BookPage.routeName,
                          arguments: data);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: new Image.asset(
                          data.service[index].strImage1,
                          width: 100,
                        ),
                      ),
                      title: Text(
                        data.service[index].itemName,
                        maxLines: 2,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            "Rp. " + oCcy.format(data.service[index].price),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                // print("tagMenu : " +
                //     provider.tagFilter +
                //     ", "
                //         "tagService : " +
                //     data.service[index].tag +
                //     ", show : " +
                //     i.toString());
                return Padding(padding: EdgeInsets.all(0));
              }
            },
          ));
        }));
  }
}
