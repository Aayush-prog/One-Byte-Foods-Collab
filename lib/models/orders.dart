import 'package:flutter/foundation.dart';

class Orders {
  final String size;
  final String selectedDate;
  final String time;

  Orders({required this.size, required this.selectedDate, required this.time});
  Orders.fromJSON(Map<String, Object?> json)
      : this(
            size: json['size']! as String,
            selectedDate: json['selectedDate']! as String,
            time: json['time'] as String);

  Map<String, Object?> toJSON() {
    return {'size': size, 'selectedDate': selectedDate, 'time': time};
  }
}
