import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';
import 'package:galeri_teknologi_bersama/provider/payment.provider.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:provider/provider.dart';

class PaymentCompleted extends StatelessWidget {
  static const routeName = '/paymentCompleted_page';
  final PaymentResponse paymentResponse;

  const PaymentCompleted({Key key, this.paymentResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembayaran"),
        ),
        body: Consumer<PaymentProvider>(builder: (context, provider, _) {
          if (provider.state == ResultState.Loading) {
            return Center(
                child: Container(
                    padding: EdgeInsets.all(30),
                    child: RefreshProgressIndicator()));
          } else if (provider.state == ResultState.HasData) {
            return Text(provider.paymentResponse.payment.va);
          } else {
            return Center(
                child: Text(
              provider.message,
              textAlign: TextAlign.center,
            ));
          }
        }));
  }
}
