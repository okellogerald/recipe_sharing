import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class Themes extends ChangeNotifier {
  String theme = 'Dark';

  void toggleThemes() {
    theme = theme == 'Light' ? 'Dark' : 'Light';
    notifyListeners();
  }
}
