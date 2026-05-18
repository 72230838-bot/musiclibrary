import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/playlist.dart';
import '../widgets/product_item.dart';
import 'youtube_player_screen.dart';
import 'playlist_screen.dart';
import 'login.dart';
import 'signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> songs = [
    Product(
      id: 1,
      title: "B.B. King - The Thrill Is Gone",
      artist: "B.B. King",
      youtubeUrl: "https://youtu.be/4fk2prKnYnI",
    ),
    Product(
      id: 2,
      title: "Muddy Waters - Mannish Boy",
      artist: "Muddy Waters",
      youtubeUrl: "https://youtu.be/w5IOou6qN1o",
    ),
    Product(
      id: 3,
      title: "Robert Johnson - Cross Road Blues",
      artist: "Robert Johnson",
      youtubeUrl: "https://youtu.be/Yd60nI4sa9A",
    ),
    Product(
      id: 4,
      title: "Howlin' Wolf - Smokestack Lightning",
      artist: "Howlin' Wolf",
      youtubeUrl: "https://youtu.be/9Ri7TcukAJ8",
    ),
    Product(
      id: 5,
      title: "John Lee Hooker - Boom Boom",
      artist: "John Lee Hooker",
      youtubeUrl: "https://youtu.be/2ElhQX2pW6s",
    ),
  ];

  List<Playlist> playlists = [
    Playlist(id: 1, name: "Favorites", songs: []),
    Playlist(id: 2, name: "Blues Classics", songs: []),
  ];

  bool isLoading = false;

  void toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
      if (product.isFavorite && playlists.isNotEmpty) {
        playlists[0].songs.add(product);
      } else if (playlists.isNotEmpty) {
        playlists[0].songs.remove(product);
      }
    });
  }

  void deleteProduct(Product product) {
    setState(() {
      songs.remove(product);
      for (var playlist in playlists) {
        playlist.songs.remove(product);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.title} deleted successfully!")),
    );
  }

  void playProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => YoutubePlayerScreen(product: product)),
    );
  }

  void openPlaylist(Playlist playlist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlaylistScreen(
          playlist: playlist,
          onToggleFavorite: toggleFavorite,
          onDelete: deleteProduct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_music, color: Colors.white),
            SizedBox(width: 8),
            Text("Music Library"),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Login"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.person_add),
                        label: const Text("Signup"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final product = songs[index];
                      return ProductItem(
                        product: product,
                        onPlay: () => playProduct(product),
                        onFavorite: () => toggleFavorite(product),
                        onDelete: () => deleteProduct(product),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.blueGrey[900],
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: playlists.map((playlist) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.playlist_play),
                        label: Text(playlist.name),
                        onPressed: () => openPlaylist(playlist),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
