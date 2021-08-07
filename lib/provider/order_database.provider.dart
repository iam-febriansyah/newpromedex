import 'package:flutter/foundation.dart';
import 'package:galeri_teknologi_bersama/data/local/order.sqlite.dart';
import 'package:galeri_teknologi_bersama/data/model/historyorderhomecare.dart';
//import 'package:galeri_teknologi_bersama/data/model/historyorder.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

class DatabaseHistoryOrderProvider extends ChangeNotifier {
  final DatabaseHistoryOrderHelper databaseHistoryOrderHelper;

  DatabaseHistoryOrderProvider({this.databaseHistoryOrderHelper}) {
    _getBookmarks();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<HistoryOrderHomeCare> _bookmarks = [];
  List<HistoryOrderHomeCare> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHistoryOrderHelper.getData();
    if (_bookmarks.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(HistoryOrderHomeCare bio) async {
    try {
      await databaseHistoryOrderHelper.insertData(bio);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmared = await databaseHistoryOrderHelper.getDataByUnique(url);
    return bookmared.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHistoryOrderHelper.removeData(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void removeBookmarkAll() async {
    try {
      await databaseHistoryOrderHelper.removeDataAll;
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
