import 'package:flutter/material.dart';

class CoolDrinks {
  final String name, volume, image;
  final Color color;
  final double price, rating;
  bool isFavorite;
  int count;

  CoolDrinks({
    required this.name,
    required this.volume,
    required this.image,
    required this.color,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.count,
});
}

final CoolDrinksList = [
  CoolDrinks(
    image: "zhivchik.png",
    name: "Живчик",
    volume: "750мл",
    rating: 3,
    price: 40,
    color: Colors.yellow.shade800,
    isFavorite: false,
    count: 1,

  ),
  CoolDrinks(
    image: "revo.png",
    name: "Рево",
    volume: "500мл",
    rating: 4,
    price: 58,
    color: Colors.grey.shade800,
    isFavorite: false,
    count: 1,
  ),
  CoolDrinks(
    image: "guayaba.png",
    name: "Гуаяба Дядя",
    volume: "2000мл",
    rating: 5,
    price: 49,
    color: Colors.green.shade800,
    isFavorite: false,
    count: 1,

  ),
  CoolDrinks(
    image: "kvas.png",
    name: "Квас Тарас",
    volume: "1500мл",
    rating: 5,
    price: 53,
    color: Colors.brown.shade800,
    isFavorite: false,
    count: 1,
  ),
];