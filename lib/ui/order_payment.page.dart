import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentrequest.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentstatus.dart';
import 'package:galeri_teknologi_bersama/provider/payment.provider.dart';
import 'package:galeri_teknologi_bersama/ui/order_completed.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
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
  DataOrder _dataOrder = new DataOrder();

  Future<Transaction> ftranscation() async {
    var transactions = Transaction();

    transactions.bank = _bank;
    transactions.orderId =
        "INV" + DateTime.now().toString().substring(0, 10) + "-" + "01342F0";
    transactions.grossAmount = _dataOrder.price * _dataOrder.quantity;
    transactions.customerEmail = _dataOrder.profilPasien[0].name;
    transactions.customerName = _dataOrder.profilPasien[0].name;
    transactions.customerPhone = _dataOrder.profilPasien[0].name;
    transactions.expired = 120;

    return transactions;
  }

  Future<List<ItemOrder>> ftranscationDetails() async {
    var transactionsDetails = List<ItemOrder>();

    for (int i = 0; i < _dataOrder.profilPasien.length; i++) {
      transactionsDetails.add(ItemOrder(
          price: _dataOrder.price, quantity: 1, name: _dataOrder.nameItem));
      print("==================== : " + i.toString());
    }

    return transactionsDetails;
  }

  @override
  Widget build(BuildContext context) {
    _dataOrder = widget.dataOrder;
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
                    activeColor: Colors.blue,
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
                    activeColor: Colors.blue,
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
                var transactions = await ftranscation();
                var transactionsDetails = await ftranscationDetails();

                provider.setTransactions(transactions);
                provider.setTransactionsDetails(transactionsDetails);
                provider.fetch;

                Navigator.pushReplacementNamed(
                    context, PaymentCompleted.routeName);
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
                        colors: [Color(0xFF207ce5), Color(0xFF0c92f1)])),
              ),
            );
          }),
        ],
      ),
    );
  }
}
