import 'package:flutter/services.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/data/model/merchant.dart';
import 'package:galeri_teknologi_bersama/ui/order_profil.page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookPage extends StatefulWidget {
  static const routeName = '/book_page';

  final Merchant merchant;

  const BookPage({Key key, this.merchant}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String selectDate, selectDay;
  int selected;
  int selectedJam;
  int selectedType;
  final oCcy = new NumberFormat("#,##0", "en_US");
  DataOrder dataOrder = new DataOrder();

  String tanggal;
  String jam;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Color(0xFF0c92f1),
          systemNavigationBarColor: Color(0xfffafaff), // navigation bar color
          statusBarIconBrightness: Brightness.dark, // st
        ),
        child: Scaffold(body: detailContent(context)));
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

  Widget detailContent(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.merchant.strBackground,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SafeArea(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        height: 35,
                        width: 35,
                        child: FloatingActionButton(
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      // FavoriteButton(
                      //   restaurant: restaurant,
                      // )
                    ],
                  )),
                ],
              ),
              Row(
                children: [
                  Container(
                    // alignment: Alignment.bottomLeft,
                    // margin: EdgeInsets.only(left: 20),
                    //transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    //  decoration: BoxDecoration(
                    //  borderRadius: BorderRadius.circular(5),
                    //   color: Colors.blueGrey[800].withOpacity(0.7),
                    //  ),
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        '',
                        style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.15,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              widget
                                  .merchant
                                  .service[widget.merchant.serviceClick]
                                  .itemName,
                              maxLines: 1,
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    letterSpacing: 0.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              widget.merchant.tagQuery,
                              maxLines: 1,
                              style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 92,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfffafaff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                widget.merchant.itemName + " ",
                                maxLines: 1,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    letterSpacing: 0.1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.info_sharp, size: 20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            widget.merchant.districts +
                                ", " +
                                widget.merchant.city,
                            maxLines: 1,
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 0.2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "Rp. " +
                                oCcy.format(widget
                                    .merchant
                                    .service[widget.merchant.serviceClick]
                                    .price),
                            maxLines: 1,
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                letterSpacing: 0.5,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "Pilih tanggal dan jam kunjungan",
                          maxLines: 1,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: Colors.grey[800],
                              letterSpacing: 0.1,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Text(
              //     selected == null
              //         ? 'No select date'
              //         : 'Selecte date $selectDate - $selectDay',
              //     style: TextStyle(fontStyle: FontStyle.italic)),
              Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  padding:
                      EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                  child: ListView.builder(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, position) {
                        int day = DateTime.now().day + position;
                        return GestureDetector(
                            child: FittedBox(
                                child: Container(
                                    height: 90,
                                    width: 90,
                                    margin: EdgeInsets.only(right: 15.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: new Border.all(
                                            color: selected == null
                                                ? Colors.transparent
                                                : selected == day
                                                    ? selected ==
                                                            DateTime.now().day
                                                        ? Colors.transparent
                                                        : Colors.blue
                                                    : Colors.transparent),
                                        color: selected == day
                                            ? Colors.blue.withOpacity(0.2)
                                            : Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              DateTime.now()
                                                  .add(Duration(days: position))
                                                  .day
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight:
                                                    day == DateTime.now().day
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                color: selected == day
                                                    ? Colors.black54
                                                    : Colors.grey[900],
                                              )),
                                          Text(
                                            DateFormat('EE').format(
                                                DateTime.now().add(
                                                    Duration(days: position))),
                                            style: TextStyle(
                                                color: selected == day
                                                    ? Colors.black
                                                    : Colors.grey[700],
                                                fontWeight:
                                                    day == DateTime.now().day
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                          )
                                        ]))),
                            onTap: () {
                              setState(() {
                                selectDate = DateTime.now()
                                    .add(Duration(days: position))
                                    .day
                                    .toString();
                                selectDay = DateFormat('yMd').format(
                                    DateTime.now()
                                        .add(Duration(days: position)));
                                selected = DateTime.now().day + position;

                                tanggal = selectDay.toString();

                                print('Tag2 ' + selectDay.toString());
                                print('Tag3 ' + selectDate.toString());
                              });
                            });
                      })),

              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.merchant.visitingHours.length,
                    itemBuilder: (context, index) {
                      int item = index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJam = index;

                            jam =
                                widget.merchant.visitingHours[index].toString();
                          });
                          print(selectedJam.toString());
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 70,
                          decoration: BoxDecoration(
                            color: selectedJam == item
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              widget.merchant.visitingHours[index].toString() +
                                  ":00",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "Pilih Jenis Order",
                            maxLines: 1,
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                letterSpacing: 0.1,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  height: 65,
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.all(15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.merchant.orderType.length,
                    itemBuilder: (context, index) {
                      int item = index;
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = index;
                            });
                            print(widget.merchant.orderType[index]);
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedType == item
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.1),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.merchant.orderType[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                "Informasi",
                                maxLines: 1,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Icon(Icons.info))
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 10, right: 10),
                          child: Text(
                            "Harga yang tercantum mengikuti ketentuan dari mitra penyedia layanan.",
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 10, right: 10),
                          child: Text(
                            "Deskripsi:",
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 10, right: 10),
                          child: Text(
                            widget.merchant
                                .service[widget.merchant.serviceClick].desc,
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              if (selected == null ||
                  selectedJam == null ||
                  selectedType == null) {
                snackBar("pilih tanggal, jam dan jenis order!");
              } else {
                dataOrder.date = tanggal;
                dataOrder.hours = jam;
                dataOrder.nameItem = widget
                    .merchant.service[widget.merchant.serviceClick].itemName;
                dataOrder.price =
                    widget.merchant.service[widget.merchant.serviceClick].price;
                Navigator.pushNamed(context, OrderProfilPage.routeName,
                    arguments: dataOrder);
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
        ),
      ],
    );
  }
}


// }
