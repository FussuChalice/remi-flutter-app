class Service {
  String title;
  String type;
  String address;
  String description;
  String stars_count;
  String main_image;

  Service({
    this.title = "",
    this.type = "",
    this.address = "",
    this.description = "",
    this.stars_count = "",
    this.main_image = "",
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      title: json['title'] ?? "",
      type: json['type'] ?? "",
      address: json['address'] ?? "",
      description: json['description'] ?? "",
      stars_count: json['stars_count'] ?? "",
      main_image: json['main_image'] ?? "",
    );
  }
}






