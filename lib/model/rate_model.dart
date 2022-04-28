import 'dart:convert';

class RateModel {
  double rate;
  RateModel({
    this.rate,
  });

  RateModel copyWith({
    double rate,
  }) {
    return RateModel(
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      rate: map['rate']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RateModel.fromJson(String source) => RateModel.fromMap(json.decode(source));

  @override
  String toString() => 'RateModel(rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RateModel &&
      other.rate == rate;
  }

  @override
  int get hashCode => rate.hashCode;
}
