import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/playlist.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import 'youtube_player_screen.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;
  final Function(Product)? onToggleFavorite;
  final Function(Product)? onDelete;

  const PlaylistScreen({
    super.key,
    required this.playlist,
    this.onToggleFavorite,
    this.onDelete,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<Product> songs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlaylistSongs();
  }

  Future<void> fetchPlaylistSongs() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://musiclibraryproject.onlinewebshop.net/htdocs/api/getPlaylists.php"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["status"] == "success") {
          final playlists = (data["playlists"] as List)
              .map((item) => Playlist.fromJson(item))
              .toList();

          final match = playlists.firstWhere(
            (p) => p.id == widget.playlist.id,
            orElse: () => widget.playlist,
          );

          setState(() {
            songs = match.songs;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
        }
      }
    } catch (e) {
      print("Error fetching playlist songs: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.playlist.name)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : songs.isEmpty
              ? const Center(child: Text("No songs in this playlist"))
              : ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final product = songs[index];
                    return ProductItem(
                      product: product,
                      onPlay: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                YoutubePlayerScreen(product: product),
                          ),
                        );
                      },
                      onFavorite: () {
                        if (widget.onToggleFavorite != null) {
                          widget.onToggleFavorite!(product);
                        }
                      },
                      onDelete: () {
                        if (widget.onDelete != null) {
                          widget.onDelete!(product);
                        }
                      },
                    );
                  },
                ),
    );
  }
}
