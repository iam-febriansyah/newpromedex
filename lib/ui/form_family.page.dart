import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:galeri_teknologi_bersama/provider/database_provider.dart';
import 'package:provider/provider.dart';

class FormFamilyPage extends StatefulWidget {
  static const routeName = '/FormFamily_page';

  @override
  _FormFamilyPageState createState() => _FormFamilyPageState();
}

class _FormFamilyPageState extends State<FormFamilyPage> {
  final TextEditingController _ektp = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _hp = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _tempatlahir = TextEditingController();
  final TextEditingController _tanggallahir = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _kewaranegaraan = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime _date = DateTime(2020, 11, 17);

    void _selectDate() async {
      final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2017, 1),
        lastDate: DateTime(2022, 7),
        helpText: 'Select a date',
      );
      if (newDate != null) {
        setState(() {
          _tanggallahir.text = newDate.toString().substring(0, 10);
          print(_tanggallahir.text);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Isi Data",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new Material(
                child: ListView(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _ektp,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Nomor KTP/NIK/PASSPORT / Identity Number",
                        hintText: "",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Nama / Name",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _hp,
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Nomor Whastapp / Whastapp Number",
                        hintText: "812xxxxxx",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Email",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _tempatlahir,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Tempat Lahir / Birth Place",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: new TextField(
                          controller: _tanggallahir,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.only(
                                  top: 15, right: 7, bottom: 15, left: 10),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              labelText: "Tanggal Lahir / Birth Date",
                              fillColor: Colors.white70),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () async {
                              _selectDate();
                            },
                            child: Icon(
                              Icons.date_range,
                              color: Colors.blue.withOpacity(0.9),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _alamat,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Alamat / Address",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: new TextField(
                    controller: _kewaranegaraan,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            top: 15, right: 7, bottom: 15, left: 10),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: "Kewarganegaraan / Nationality",
                        hintText: "Indonesia",
                        fillColor: Colors.white70),
                  ),
                ),
              ],
            )),
          ),
          Consumer<DatabaseProvider>(
            builder: (context, provider, _) {
              return GestureDetector(
                onTap: () {
                  Bio bio = new Bio();
                  bio.name = _name.text.toUpperCase();
                  bio.nik = _ektp.text;
                  bio.isChecked = 0;
                  provider.addBookmark(bio);
                  Navigator.pop(context);
                },
                child: new Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Simpan",
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
            },
          ),
        ],
      ),
    );
  }
}
