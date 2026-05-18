import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/product.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final Product product;

  const YoutubePlayerScreen({super.key, required this.product});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  late Product currentProduct;

  @override
  void initState() {
    super.initState();
    // نخزن نسخة محلية من الـ Product
    currentProduct = widget.product;

    final videoId =
        YoutubePlayer.convertUrlToId(currentProduct.youtubeUrl) ?? "";
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addToFavorites() {
    setState(() {
      currentProduct.isFavorite = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${currentProduct.title} added to Favorites")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(currentProduct.title),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.redAccent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              currentProduct.artist,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.favorite),
                label: const Text("Add to Favorites"),
                onPressed: addToFavorites,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
