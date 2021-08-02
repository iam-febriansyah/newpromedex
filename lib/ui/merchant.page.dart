import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/service.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/cardhome.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantPage extends StatefulWidget {
  static const routeName = '/merchant_page';
  final List<String> data;
  MerchantPage({this.data});

  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int filter = 0;

  @override
  Widget build(BuildContext context) {
    //print(widget.data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data[1],
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
    return Consumer<MenuProvider>(builder: (context, provider, _) {
      if (provider.stateMerchant == ResultState.Loading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RefreshProgressIndicator(),
          ),
        );
      } else if (provider.stateMerchant == ResultState.HasData) {
        List<Merchant> merchantFilter = [];
        var data = provider.responseMerchant.merchants;

        data.forEach((u) {
          var tag = u.tag.toString();
          if (tag.contains(widget.data[2])) {
            merchantFilter.add(u);
          }
        });

        return ListView.builder(
          itemCount: merchantFilter.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () {
                  merchantFilter[index].tagFilter = widget.data[2];
                  print(merchantFilter[index].tagFilter);
                  //  print(merchantFilter[index].tag);
                  Navigator.pushNamed(
                    context,
                    LayananPage.routeName,
                    arguments: merchantFilter[index],
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
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
                      border: Border.all(
                          width: 1,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  margin: EdgeInsets.only(top: 10),
                  child: new ListTile(
                    leading: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: new Image.network(
                          merchantFilter[index].strBackground,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text(
                        merchantFilter[index].itemName,
                        maxLines: 2,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, top: 2),
                          child: new Text(
                            merchantFilter[index].districts +
                                ", " +
                                merchantFilter[index].city,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, top: 2),
                          child: new Text(
                            "Open : 0" +
                                merchantFilter[index].open.toString() +
                                ".00 s/d " +
                                merchantFilter[index].close.toString() +
                                ".00",
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Text("");
      }
    });
  }

  // Widget merchant(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: firestore
  //         .collection("merchant")
  //         .where('isOpen', isEqualTo: true)
  //         .firestore
  //         .collection("merchant")
  //         .where('tag', arrayContains: widget.data[2])

  //         //.orderBy('dateCreated', descending: true)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       return new ListView(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: 8.0,
  //           vertical: 16.0,
  //         ),
  //         children: snapshot.data.docs.map((DocumentSnapshot document) {
  //           // Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //           Merchant merchant = Merchant.fromJson(document.data());
  //           merchant.tagQuery = widget.data[2];

  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.pushNamed(
  //                 context,
  //                 LayananPage.routeName,
  //                 arguments: merchant,
  //               );
  //             },
  //             child: Container(
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: new ListTile(
  //                 leading: Container(
  //                   width: 100,
  //                   child: new Image.network(
  //                     merchant.strBackground,
  //                     fit: BoxFit.fitWidth,
  //                   ),
  //                 ),
  //                 title: Padding(
  //                   padding: const EdgeInsets.all(2.0),
  //                   child: new Text(
  //                     merchant.itemName,
  //                     maxLines: 1,
  //                   ),
  //                 ),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 2.0, top: 2),
  //                       child: new Text(
  //                         merchant.districts + ", " + merchant.city,
  //                         maxLines: 1,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 2.0, top: 2),
  //                       child: new Text(
  //                         "Buka  Jam : 0" +
  //                             merchant.open.toString() +
  //                             ".00 s/d " +
  //                             merchant.close.toString() +
  //                             ".00",
  //                         style: TextStyle(
  //                           color: Colors.green[900],
  //                         ),
  //                         maxLines: 1,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
}
