class Shoe {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String type;
  final String description;

  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.type,
    required this.description,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'],
      name: json['nama'], // Perhatikan perubahan nama field
      price: json['harga'],
      imageUrl: json['gambar'],
      type: json['tipe'],
      description: json['deskripsi'],
    );
  }
}
