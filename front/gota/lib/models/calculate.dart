import 'dart:ffi';

class Calculate {
  String value;
  bool status;
  String filled;

  Calculate({required this.value, required this.status, required this.filled});

  Map<String, dynamic> toJson() {
    return {'value': value, 'status': status, 'filled': filled};
  }

  factory Calculate.fromJson(Map<String, dynamic> json) {
    return Calculate(
      value: json['value'] as String,
      status: json['status'] as bool,
      filled: json['filled'] as String,
    );
  }
}
