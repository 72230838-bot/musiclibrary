import 'product.dart';

class Playlist {
  final int id;
  final String name;
  List<Product> songs;

  Playlist({
    required this.id,
    required this.name,
    this.songs = const [],
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: int.parse(json["id"].toString()),
      name: json["name"],
      songs: [],
    );
  }
}
