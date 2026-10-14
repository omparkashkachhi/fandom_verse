import 'package:flutter/material.dart';
import '../models/fandom_model.dart';

class FandomProvider extends ChangeNotifier {
  final List<Fandom> _fandoms = [
    Fandom(
      id: 'f1',
      name: 'Mystic Warriors',
      category: 'Anime',
      fans: '1.2M Fans',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500',
      description: 'An epic realm of elemental anime warriors battling ancient dark forces.',
    ),
    Fandom(
      id: 'f2',
      name: 'Pixel Quest',
      category: 'Gaming',
      fans: '980K Fans',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=500',
      description: 'Retro pixelated RPG world filled with secret dungeons and boss fights.',
    ),
    Fandom(
      id: 'f3',
      name: 'Nova Realms',
      category: 'Sci-Fi',
      fans: '2.4M Fans',
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=500',
      description: 'Futuristic galaxies, starships, and deep space exploration lore.',
    ),
  ];

  List<Fandom> get fandoms => _fandoms;

  List<Fandom> searchFandoms(String query) {
    if (query.isEmpty) return _fandoms;
    return _fandoms.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}