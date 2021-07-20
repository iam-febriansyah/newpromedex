import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/merchant.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/ui/service.page.dart';
import 'package:galeri_teknologi_bersama/widget/cardhome.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantPage extends StatelessWidget {
  static const routeName = '/merchant_page';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<String> data;
  MerchantPage({this.data});

  @override
  Widget build(BuildContext context) {
    print(data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data[1],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [Expanded(child: merchant(context))],
        ),
      ),
    );
  }

  Widget merchant(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("merchant")
          .where('isOpen', isEqualTo: true)
          .firestore
          .collection("merchant")
          .where('tag', arrayContains: data[2])

          //.orderBy('dateCreated', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return new ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            // Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Merchant merchant = Merchant.fromJson(document.data());
            merchant.tagQuery = data[2];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  LayananPage.routeName,
                  arguments: merchant,
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: new ListTile(
                  leading: Container(
                    width: 100,
                    child: new Image.network(
                      merchant.strBackground,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: new Text(
                      merchant.itemName,
                      maxLines: 1,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, top: 2),
                        child: new Text(
                          merchant.districts + ", " + merchant.city,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, top: 2),
                        child: new Text(
                          "Buka  Jam : 0" +
                              merchant.open.toString() +
                              ".00 s/d " +
                              merchant.close.toString() +
                              ".00",
                          style: TextStyle(
                            color: Colors.green[900],
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
