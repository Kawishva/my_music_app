import 'package:flutter/foundation.dart';

class NavigationBarChange extends ChangeNotifier {
  int navigationBarIndex = 0;
  int playListviewSelectedIndex = -1;
  bool screenIsAllSongsScreen = true;
  bool audioTrayersAreVisible = false;
  bool playListNameChange = false;
  String playListName = "";
  String tempPlayListName = "";

  /// Updates the navigation bar index and related properties.
  void navigationBarIndexChangeFunction(int navigationBarIndex,
      int playListviewSelectedIndex, String tempPlayListName) {
    this.navigationBarIndex = navigationBarIndex;
    this.playListviewSelectedIndex = playListviewSelectedIndex;
    this.tempPlayListName = tempPlayListName;

    // Determine if the current screen is the all songs screen
    this.screenIsAllSongsScreen = (navigationBarIndex == 0);

    notifyListeners();
  }

  /// Sets the playlist name if the name change flag is true.
  void setplayListNamgechange(bool playListNameChange) {
    if (playListNameChange) {
      this.playListName = this.tempPlayListName;
    }
    notifyListeners();
  }

  /// Sets audio tray visibility to true.
  void setAudioTrayersAreVisible() {
    this.audioTrayersAreVisible = true;
    notifyListeners();
  }

  /// Toggles the visibility of the audio tray.
  void onAudioTrayCloseFuntion() {
    this.audioTrayersAreVisible = !this.audioTrayersAreVisible;
    notifyListeners();
  }

  /// Getters to access private properties.
  String get getPlayListName => this.playListName;
  int get navigationIndex => this.navigationBarIndex;
  int get playListviewIndex => this.playListviewSelectedIndex;
  bool get isAllSongsScreen => this.screenIsAllSongsScreen;
  bool get getAudioTrayVisibility => this.audioTrayersAreVisible;
}
