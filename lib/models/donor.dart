class DonorFood {
  DonorFood({
    required this.image,
    required this.about,
    required this.createdAt,
  });

  late String image;
  late String about;
  late String createdAt;

  DonorFood.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['created_at'] = createdAt;
    return data;
  }
}
