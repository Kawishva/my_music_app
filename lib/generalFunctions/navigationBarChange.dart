import 'package:flutter/foundation.dart';

class NavigationBarChange extends ChangeNotifier {
  int navigationBarIndex = 0;
  int playListviewSelectedIndex = -1;
  bool screenIsAllSongsScreen = true;
  bool audioTrayersAreVisible = false;
  bool playListNamgechange = false;
  String playListName = "";
  String tempPlayListName = "";

  void navigationBarIndexChangeFunction(int navigationBarIndex,
      int playListviewSelectedIndex, String tempPlayListName) {
    this.navigationBarIndex = navigationBarIndex;
    this.playListviewSelectedIndex = playListviewSelectedIndex;
    this.tempPlayListName = tempPlayListName;

    if (navigationBarIndex == 0) {
      this.screenIsAllSongsScreen = true;
    } else {
      this.screenIsAllSongsScreen = false;
    }

    notifyListeners();
  }

  void setplayListNamgechange(bool playListNamgechange) {
    if (playListNamgechange) {
      this.playListName = this.tempPlayListName;
    }
    notifyListeners();
  }

  void setAudioTrayersAreVisible() {
    this.audioTrayersAreVisible = true;
    notifyListeners();
  }

  void onAudioTrayCloseFuntion() {
    this.audioTrayersAreVisible = !this.audioTrayersAreVisible;
    notifyListeners();
  }

  String get getPlayListName => this.playListName;
  int get navigationIndex => this.navigationBarIndex;
  int get playListviewIndex => this.playListviewSelectedIndex;
  bool get isAllSongsScreen => this.screenIsAllSongsScreen;
  bool get getAudioTrayVisibility => this.audioTrayersAreVisible;
}
