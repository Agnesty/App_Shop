import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';

class FavoriteItems extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;

  const FavoriteItems({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProdukDetailScreen.routeName, arguments: id);
        },
        child: Column(children: [
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.grey.shade300,
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    height: 40,
                    width: 150,
                    child: Center(
                        child: Text(
                      title,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
              Positioned(
                  top: 5,
                  left: 5,
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: Colors.red,
                  ))
            ]),
          ),
        ]),
      ),
    );
  }
}
