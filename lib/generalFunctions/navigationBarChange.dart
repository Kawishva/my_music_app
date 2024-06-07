import 'package:flutter/foundation.dart';

class NavigationBarChange extends ChangeNotifier {
  int navigationBarIndex = 0;
  int playListviewSelectedIndex = -1;
  bool screenIsAllSongsScreen = false;

  void navigationBarIndexChangeFunction(
      int navigationBarIndex, int playListviewSelectedIndex) {
    this.navigationBarIndex = navigationBarIndex;
    this.playListviewSelectedIndex = playListviewSelectedIndex;

    if (navigationBarIndex == 1) {
      this.screenIsAllSongsScreen = true;
    } else {
      this.screenIsAllSongsScreen = false;
    }

    notifyListeners();
  }

  int get navigationIndex => this.navigationBarIndex;
  int get playListviewIndex => this.playListviewSelectedIndex;
  bool get isAllSongsScreen => this.screenIsAllSongsScreen;
}
