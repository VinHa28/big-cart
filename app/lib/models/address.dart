class Address {
  final String? id; // Thêm trường ID (nullable)
  final String fullname;
  final String phoneNumber;
  final String address;
  final String city;
  final String country;
  final bool isDefault;

  Address({
    this.id, // Thêm vào constructor
    required this.fullname,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.country,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'], // Map trường _id từ MongoDB vào id
      fullname: json['fullname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? 'Vietnam',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // Thường không gửi ID khi tạo mới, server tự sinh
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'country': country,
      'isDefault': isDefault,
    };
  }
}
