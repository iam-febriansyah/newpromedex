import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/data/model/request/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/response/listswabber.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';

import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
import 'package:galeri_teknologi_bersama/ui/order_completed.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_track_location.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

enum BANK { bca, bni }

/// This is the stateful widget that the main application instantiates.
class PaymentMethode extends StatefulWidget {
  static const routeName = '/paymentMethode_page';
  final DataOrder dataOrder;

  const PaymentMethode({Key key, this.dataOrder}) : super(key: key);

  @override
  State<PaymentMethode> createState() => _PaymentMethodeState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PaymentMethodeState extends State<PaymentMethode> {
  BANK _character = BANK.bca;
  String _bank = "BCA";
  List<DataOrderTransactionDetail> _dataOrderTransactionDetail = [];
  ResponseListSwabber responseListSwabber = new ResponseListSwabber();

  bool onPressPayment;

  Color colorRegistrasi = Color(0xFF43b752);

  Future<RequestTransaction> ftranscation() async {
    var providerMenu = Provider.of<MenuProvider>(context, listen: false);

    var transactions = RequestTransaction();
    transactions.channel = _bank;
    transactions.customerEmail = "test123@gmail.com";
    transactions.customerName = "test";
    transactions.customerPhone = "08129000";

    if (providerMenu.tagFilter.contains("homecare")) {
      // var idSwabber = providerMenu.responseListSwabber.listSwabbers[1].id;
      transactions.idswabber = 100;
      transactions.latitude = providerMenu.userLocationLatitude;
      transactions.longitude = providerMenu.userLocationLongitude;
      transactions.type = "homecare";
      transactions.address = providerMenu.userLocationAddres;

      print("homecare  ");
    } else {
      transactions.idswabber = null;
      transactions.latitude = "";

      transactions.longitude = "";
      transactions.type = "walkin";
      print("walk in  ");
    }

    return transactions;
  }

  Future<List<RequestTransactionDetail>> ftranscationDetails() async {
    var transactionsDetails = List<RequestTransactionDetail>();

    for (int i = 0; i < _dataOrderTransactionDetail.length; i++) {
      transactionsDetails.add(RequestTransactionDetail(
        clientId: _dataOrderTransactionDetail[i].clientId,
        identityNumber: _dataOrderTransactionDetail[i].identityNumber,
        identityParentNumber:
            _dataOrderTransactionDetail[i].identityParentNumber,
        name: _dataOrderTransactionDetail[i].name,
        gender: _dataOrderTransactionDetail[i].gender,
        birthDay: _dataOrderTransactionDetail[i].birthDay,
        birthPlace: _dataOrderTransactionDetail[i].birthPlace,
        nationality: _dataOrderTransactionDetail[i].nationality,
        address: _dataOrderTransactionDetail[i].address,
        phone: _dataOrderTransactionDetail[i].phone,
        email: _dataOrderTransactionDetail[i].email,
        serviceClientId: _dataOrderTransactionDetail[i].serviceClientId,
        price: _dataOrderTransactionDetail[i].price,
        orderType: _dataOrderTransactionDetail[i].orderType,
        dateReservation: _dataOrderTransactionDetail[i].dateReservation,
        hourReservation: _dataOrderTransactionDetail[i].hourReservation,
      ));
      print("==================== : " + i.toString());
    }

    return transactionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    var providerMenu = Provider.of<MenuProvider>(context);

    _dataOrderTransactionDetail = widget.dataOrder.transactionDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Metode Pembayaran",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('BANK BCA'),
                  leading: Radio<BANK>(
                    activeColor: Colors.green.withOpacity(0.7),
                    value: BANK.bca,
                    groupValue: _character,
                    onChanged: (BANK value) {
                      setState(() {
                        _character = value;
                        _bank = "BCA";
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      const Text('BANK BNI'),
                    ],
                  ),
                  leading: Radio<BANK>(
                    activeColor: Colors.green.withOpacity(0.7),
                    value: BANK.bni,
                    groupValue: _character,
                    onChanged: (BANK value) {
                      setState(() {
                        _character = value;
                        _bank = "BNI";
                      });
                    },
                  ),
                )
              ],
            ),
          )),
          Consumer<PaymentProvider>(builder: (context, provider, _) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  colorRegistrasi = Color(0xFF43b752).withOpacity(0.6);
                });
                var transactions = await ftranscation();
                var transactionsDetails = await ftranscationDetails();

                await provider.setTransactions(transactions);
                await provider.setTransactionsDetails(transactionsDetails);
                await provider.fetch;

                if (providerMenu.tagFilter.contains("homecare")) {
                  Navigator.pushReplacementNamed(
                      context, PaymentTrack.routeName);
                } else {
                  Navigator.pushReplacementNamed(
                      context, PaymentCompleted.routeName);
                }
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Proses Registrasi",
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
                        colors: [colorRegistrasi, colorRegistrasi])),
              ),
            );
          }),
        ],
      ),
    );
  }
}
