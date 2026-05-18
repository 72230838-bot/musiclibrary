class Product {
  final int id;
  final String title;
  final String artist;
  final String youtubeUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.artist,
    required this.youtubeUrl,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json["id"].toString()),
      title: json["title"],
      artist: json["artist"],
      youtubeUrl: json["url"],
    );
  }
}
