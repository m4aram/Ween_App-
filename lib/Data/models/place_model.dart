class PlaceModel {
  final String id;
  final String name;
  final String country;
  final String imagePath;
  final String phone;
  final String web;
  final String instagram;
  final List<String> galleryImages;
  final String? menuImage;
  final String? menuUrl;
  final List<String> tags;
  final String city;

  PlaceModel({
    required this.id,
    required this.name,
    required this.country,
    required this.imagePath,
    required this.phone,
    required this.web,
    required this.instagram,
    required this.galleryImages,
    this.menuImage,
    this.menuUrl,
    this.tags = const [],
    this.city = '',
  });
}