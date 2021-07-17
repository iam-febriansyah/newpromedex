import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/merchant.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galeri_teknologi_bersama/ui/book.page.dart';

class LayananPage extends StatelessWidget {
  static const routeName = '/service_page';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Merchant data;
  LayananPage({this.data});

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
      body: SafeArea(
          child: ListView.builder(
        itemCount: data.service.length,
        itemBuilder: (context, index) {
          if (data.service[index].tag.contains(data.tagQuery)) {
            return GestureDetector(
              onTap: () {
                data.serviceClick = index;
                Navigator.pushNamed(context, BookPage.routeName,
                    arguments: data);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListTile(
                  leading: new Image.asset(
                    data.service[index].strImage1,
                    width: 100,
                  ),
                  title: Text(
                    data.service[index].itemName,
                    maxLines: 2,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Rp. " + data.service[index].price.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Padding(padding: EdgeInsets.all(0));
          }
        },
      )),
    );
  }
}
