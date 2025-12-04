import 'package:flutter/material.dart';
import '../models/fortune_color.dart';
import '../models/star_card.dart';
import '../models/action_item.dart';

class FortuneProvider with ChangeNotifier {
  FortuneColor? _selectedColor;
  StarCard? _selectedStar;
  ActionItem? _selectedAction;
  int _currentStep = 0;

  FortuneColor? get selectedColor => _selectedColor;
  StarCard? get selectedStar => _selectedStar;
  ActionItem? get selectedAction => _selectedAction;
  int get currentStep => _currentStep;

  void selectColor(FortuneColor color) {
    _selectedColor = color;
    notifyListeners();
  }

  void selectStar(StarCard star) {
    _selectedStar = star;
    notifyListeners();
  }

  void selectAction(ActionItem action) {
    _selectedAction = action;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void reset() {
    _selectedColor = null;
    _selectedStar = null;
    _selectedAction = null;
    _currentStep = 0;
    notifyListeners();
  }
}
