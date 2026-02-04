import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import '../models/order_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = "Guest";
  String _userId = "";
  String _avatarUrl = "";
  double _balance = 0.0;
  List<Order> _orders = [];
  final List<String> _favorites = []; // List of Companion IDs

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userId => _userId;
  String get avatarUrl => _avatarUrl;
  double get balance => _balance;
  List<Order> get orders => _orders;
  List<String> get favorites => _favorites;

  void login(String name, String password) {
    // Mock Login Logic
    _isLoggedIn = true;
    _userName = name.isNotEmpty ? name : "玩家一号";
    _userId = "9527${DateTime.now().second}";
    _avatarUrl = "https://api.dicebear.com/7.x/avataaars/png?seed=${_userName}";
    _balance = 1288.0; // Give some initial money
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = "游客";
    _userId = "";
    _balance = 0.0;
    _orders = [];
    _favorites.clear();
    notifyListeners();
  }

  bool placeOrder(Companion companion, int hours) {
    double totalCost = companion.price * hours;
    if (_balance >= totalCost) {
      _balance -= totalCost;
      _orders.insert(
        0,
        Order(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          companion: companion,
          orderTime: DateTime.now(),
          amount: totalCost,
          hours: hours,
          status: "进行中",
        ),
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void toggleFavorite(String companionId) {
    if (_favorites.contains(companionId)) {
      _favorites.remove(companionId);
    } else {
      _favorites.add(companionId);
    }
    notifyListeners();
  }

  bool isFavorite(String companionId) {
    return _favorites.contains(companionId);
  }
}
