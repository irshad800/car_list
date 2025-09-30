class Car {
  final String name;
  final String modelCode;
  final String color;
  final int distanceCovered;
  final int engineCapacity;
  final int price;
  final bool hasCashback;
  final String make;
  final String condition;
  final String bodyType;
  final String image;

  Car({
    required this.name,
    required this.modelCode,
    required this.color,
    required this.distanceCovered,
    required this.engineCapacity,
    required this.price,
    required this.hasCashback,
    required this.make,
    required this.condition,
    required this.bodyType,
    required this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['name'] ?? 'Unknown',
      modelCode: json['modelCode'] ?? 'N/A',
      color: json['color'] ?? 'N/A',
      distanceCovered: json['distanceCovered'] ?? 0,
      engineCapacity: json['engineCapacity'] ?? 0,
      price: json['price'] ?? 0,
      hasCashback: json['hasCashback'] ?? false,
      make: json['make'] ?? 'Unknown',
      condition: json['condition'] ?? 'N/A',
      bodyType: json['bodyType'] ?? 'N/A',
      image: json['image'] ?? '',
    );
  }
}
