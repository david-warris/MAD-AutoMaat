import 'package:automaat_mad/utils/favourite_storage.dart';
import 'package:flutter/material.dart';

   class FavoriteStar extends StatefulWidget {
  final String carId;
  final bool text;

  const FavoriteStar({super.key, required this.carId, this.text = false});

  @override
  State<FavoriteStar> createState() => _FavoriteStarState();
}

class _FavoriteStarState extends State<FavoriteStar> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  void _loadFavorite() async {
    final fav = await FavoriteStorage.isFavorite(widget.carId);
    setState(() => isFavorite = fav);
  }

  void _toggleFavorite() async {
    await FavoriteStorage.toggleFavorite(widget.carId);
    setState(() => isFavorite = !isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorite,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite ? Colors.orange : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 4),
          if (widget.text)
            Text(
              isFavorite ? 'Remove from favorites' : 'Add to favorites',
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
