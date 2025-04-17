import 'dart:io';

class Game {
  final String? id;
  final String name;
  final String releaseDate;
  final String developer;
  final String publisher;
  final String category;
  final double price;
  final File? featuredImage;
  final String imageUrl;
  final String description;

  Game({
    this.id,
    required this.name,
    required this.releaseDate,
    required this.developer,
    required this.publisher,
    required this.category,
    required this.price,
    this.featuredImage,
    this.imageUrl = '',
    required this.description,
  });

  Game copyWith({
    String? id,
    String? name,
    String? releaseDate,
    String? developer,
    String? publisher,
    String? category,
    double? price,
    File? featuredImage,
    String? imageUrl,
    String? description,
  }) {
    return Game(
      id: id ?? this.id,
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
      developer: developer ?? this.developer,
      publisher: publisher ?? this.publisher,
      category: category ?? this.category,
      price: price ?? this.price,
      featuredImage: featuredImage ?? this.featuredImage,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  bool hasFeaturedImage() {
    return featuredImage != null || imageUrl.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'releaseDate': releaseDate,
      'developer': developer,
      'publisher': publisher,
      'category': category,
      'price': price,
      'description': description,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      releaseDate: json['releaseDate'],
      developer: json['developer'],
      publisher: json['publisher'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'],
    );
  }
}
