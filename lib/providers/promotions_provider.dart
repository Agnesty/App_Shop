import 'package:flutter/material.dart';

class Promotions with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String title;
  final int discount;
  final String description;

  Promotions({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.discount,
    required this.description,
  });
}

class PromotionsProducts with ChangeNotifier {
  List<Promotions> promoProduct = [
    Promotions(
        description:
            'If you buy up to 100K',
        discount: 50,
        id: 'pm1',
        imageUrl: 'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1675135260~exp=1675135860~hmac=eb1e39c129f3c25580fcaf719d8b78003442aeb1f22aca78e2890419d384d711',
        title: 'Holiday Price'),
    Promotions(
        description:
            'If you buy up to 800K',
        discount: 90,
        id: 'pm2',
        imageUrl: 'https://img.freepik.com/free-psd/golden-black-friday-sale-banner-wavy-fabric-background_1361-2850.jpg?w=996&t=st=1675135213~exp=1675135813~hmac=8efbad2c79e392445e99630b85587285cb8ddf1a9a6f35fb323cefedd73f2d12',
        title: 'Black Friday'),
    Promotions(
        description:
            'If you buy up to 500K',
        discount: 70,
        id: 'pm3',
        imageUrl:
            'https://img.freepik.com/free-vector/flat-travel-background_23-2148043314.jpg?w=740&t=st=1675136479~exp=1675137079~hmac=f5ceaa2fdc6db7da41abd059050f1f498ab7be4f32b71723fb0217c1c2c7173b',
        title: 'Desember Events'),
  ];

  List<Promotions> get promoItem {
    return [...promoProduct];
  }
}
