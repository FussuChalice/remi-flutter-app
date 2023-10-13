class Service {
  final String title;
  final String type;
  final String address;
  final String description;
  final String stars_count;

  const Service(
    {
      required this.title,
      required this.type,
      required this.address,
      required this.description,
      required this.stars_count
    }
  );

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      title: json['title'],
      type: json['type'],
      address: json['address'],
      description: json['description'],
      stars_count: json['stars_count'],
    );
  }
}