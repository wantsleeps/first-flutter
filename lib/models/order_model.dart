import 'companion_model.dart';

class Order {
  final String id;
  final Companion companion;
  final DateTime orderTime;
  final double amount;
  final int hours;
  final String status; // "进行中", "已完成", "已取消"

  Order({
    required this.id,
    required this.companion,
    required this.orderTime,
    required this.amount,
    required this.hours,
    required this.status,
  });
}
