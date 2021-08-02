import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PaymentCompleted extends StatefulWidget {
  static const routeName = '/paymentCompleted_page';

  const PaymentCompleted({Key key}) : super(key: key);

  @override
  _PaymentCompletedState createState() => _PaymentCompletedState();
}

class _PaymentCompletedState extends State<PaymentCompleted> {
  final oCcy = new NumberFormat("#,##0", "en_US");

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembayaran", style: TextStyle(color: Colors.white)),
        ),
        body: Consumer<PaymentProvider>(builder: (context, provider, _) {
          if (provider.state == ResultState.Loading) {
            return Center(
                child: Container(
                    padding: EdgeInsets.all(30),
                    child: RefreshProgressIndicator()));
          } else if (provider.state == ResultState.NoData) {
            return Center();
          } else if (provider.state == ResultState.HasData) {
            var data = provider.responsePayment;
            //  print(data.data.transactionId + "=================");
            return ListView(
              children: [
                ListTile(
                    title: Text("Total Pembayaran "),
                    trailing: Text(
                      "Rp. " +
                          oCcy.format(
                              provider.responsePayment.data.grossAmount),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.blueGrey,
                            letterSpacing: 0.1,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 10,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                  title: Text("BANK " + provider.responsePayment.data.bank),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text("No. Rekening:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.responsePayment.data.va,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w800),
                            ),
                            GestureDetector(
                              onTap: () async {
                                ClipboardData data = ClipboardData(
                                    text: provider.responsePayment.data.va);
                                await Clipboard.setData(data);
                                snackBar("Berhasil Disalin . .");
                              },
                              child: Text(
                                "SALIN",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 10,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Petunjuk Transfer mBanking"),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.4),
                                    shape: BoxShape.circle),
                                child: Center(child: Text("1")),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text("Pilih m-Transfer > " +
                                    provider.responsePayment.data.bank +
                                    " Virtual Account"),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.4),
                                    shape: BoxShape.circle),
                                child: Center(child: Text("2")),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                      "Masukkan nomor Virtual Account " +
                                          provider.responsePayment.data.va +
                                          " dan pilih send"),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.4),
                                    shape: BoxShape.circle),
                                child: Center(child: Text("3")),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text("Masukkan PIN m-" +
                                    provider.responsePayment.data.bank +
                                    " Anda dan pilih OK."),
                              ))
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 10,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            );
          } else {
            return Text("");
          }
        }));
  }
}
