class Tank {
  String id;
  String? model;
  double? capacity;
  double? initialMeasure;
  double? finalMeasure;

  Tank({
    required this.id,
    this.model,
    this.capacity,
    this.initialMeasure,
    this.finalMeasure,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'capacity': capacity,
      'initialMeasure': initialMeasure,
      'finalMeasure': finalMeasure,
    };
  }

  factory Tank.fromJson(Map<String, dynamic> json) {
    return Tank(
      id: json['id'] as String,
      model: json['model'] as String?,
      capacity: (json['capacity'] as num?)?.toDouble(),
      initialMeasure: (json['initialMeasure'] as num?)?.toDouble(),
      finalMeasure: (json['finalMeasure'] as num?)?.toDouble(),
    );
  }
}
