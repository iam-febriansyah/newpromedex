import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/provider/bottomnav.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/service.page.dart';
import 'package:galeri_teknologi_bersama/ui/merchant.page.dart';
import 'package:provider/provider.dart';

class CardHome extends StatelessWidget {
  final String itemID;
  final String itemName;
  final String tag;
  final String collect;
  final String image;

  CardHome({this.itemID, this.itemName, this.tag, this.collect, this.image});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<String> data = [itemID, itemName, tag, collect, image];

    return Consumer<MenuProvider>(builder: (context, provider, _) {
      return GestureDetector(
        onLongPress: () {},
        onTap: () {
          provider.fetchMerchant;
          provider.setTagFilter(data[2]);
          print(data[2]);
          Navigator.pushNamed(
            context,
            MerchantPage.routeName,
            arguments: data,
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                  width: 1, color: Colors.white, style: BorderStyle.solid)),
          height: 70.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 7.0, right: 7.0, top: 10.0),
                  width: 100,
                  child: Text(
                    itemName,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      );
    });
  }
}
