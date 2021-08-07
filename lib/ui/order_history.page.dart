import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:galeri_teknologi_bersama/provider/order_database.provider.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatelessWidget {
  static const routeName = '/orderhistory_page';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pemesanan Homecare",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<DatabaseHistoryOrderProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.HasData) {
            return ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                var data = provider.bookmarks[index];

                return FutureBuilder<bool>(
                    future: provider.isBookmarked(data.id.toString()),
                    builder: (context, snapshot) {
                      var isBookmarked = snapshot.data ?? false;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("type :" + "homecare"),
                          // Text("Swabber :" + "Swabber name"),
                          // Text("Phone :" + "Swabber Phone"),
                          Material(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                data.invoiceNumber,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              trailing: isBookmarked
                                  ? IconButton(
                                      icon: Icon(FlutterIcons.trash_evi),
                                      color: Colors.black.withOpacity(0.6),
                                      onPressed: () => provider
                                          .removeBookmark(data.id.toString()),
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.bookmark_border),
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0, bottom: 0),
                            height: 5,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      );
                    });
              },
            );
          } else if (provider.state == ResultState.NoData) {
            return Center(
                child: Text(
              provider.message,
              textAlign: TextAlign.center,
            ));
          } else if (provider.state == ResultState.Error) {
            return Center(
                child: Text(
              provider.message,
              textAlign: TextAlign.center,
            ));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
