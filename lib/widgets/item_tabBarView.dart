import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/auth.dart';
import '../providers/cart_provider.dart';

class ItemTabBarView extends StatelessWidget {
  const ItemTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProdukDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Container(
              height: 360,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: product.id as String,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/Agnesty_Portf_App.png'),
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
          Positioned(
            top: 310,
            left: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 80,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rp ${product.price.toStringAsFixed(3)}',
                          style: TextStyle(fontSize: 18, color: Colors.pink),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pink.shade100),
              child: IconButton(
                  onPressed: () {
                    cart.addItem(product.id!, product.price, product.title,
                        product.imageUrl);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Added Item to Cart!',
                      ),
                      duration: Duration(seconds: 5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id!);
                        },
                      ),
                    ));
                  },
                  icon: Icon(Icons.add_shopping_cart_sharp)),
            ),
          ),
          Positioned(
            bottom: 75,
            right: 18,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.red.shade400, shape: BoxShape.circle),
              child: Consumer<Product>(
                builder: (context, product, _) => IconButton(
                  onPressed: () {
                    product.toggleFavoriteStatus(
                        authData.token!, authData.userId!);
                  },
                  icon: Icon(
                    product.isFavorite!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
