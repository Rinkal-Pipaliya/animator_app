class SolarModel {
  String? position;
  String? name;
  String? image;
  String? year;
  String? type;
  String? radius;
  String? velocity;
  String? distance;
  String? description;

  SolarModel({
    this.position,
    this.name,
    this.image,
    this.year,
    this.type,
    this.radius,
    this.velocity,
    this.distance,
    this.description,
  });

  factory SolarModel.mapToModel(Map m1) {
    return SolarModel(
      position: m1['position'],
      name: m1['name'],
      image: m1['image'],
      year: m1['year'],
      type: m1['type'],
      radius: m1['radius'],
      velocity: m1['velocity'],
      distance: m1['distance'],
      description: m1['description'],
    );
  }
}
