import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onPlay;
  final VoidCallback onFavorite;
  final VoidCallback onDelete;

  const ProductItem({
    super.key,
    required this.product,
    required this.onPlay,
    required this.onFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade900,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.music_note,
            color: Colors.lightBlueAccent, size: 28),
        title: Text(
          product.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(product.artist,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                tooltip: "Play Song",
                icon:
                    const Icon(Icons.play_arrow, color: Colors.lightBlueAccent),
                onPressed: onPlay),
            IconButton(
              tooltip: product.isFavorite
                  ? "Remove from Favorites"
                  : "Add to Favorites",
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.redAccent : Colors.white70,
              ),
              onPressed: onFavorite,
            ),
            IconButton(
                tooltip: "Delete Song",
                icon: const Icon(Icons.delete, color: Colors.orangeAccent),
                onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
