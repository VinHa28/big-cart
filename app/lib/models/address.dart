class Address {
  final String fullname;
  final String phoneNumber;
  final String address;
  final String city;
  final String country;
  final bool isDefault;

  Address({
    required this.fullname,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.country,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      fullname: json['fullname'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      country: json['country'] ?? 'Vietnam',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'country': country,
      'isDefault': isDefault,
    };
  }
}
