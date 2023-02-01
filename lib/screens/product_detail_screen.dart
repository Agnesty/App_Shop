import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart_provider.dart';
import '../providers/products.dart';
import '../providers/products_provider.dart';

class ProdukDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProdukDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.pink.shade100,
                  child: Hero(
                    tag: loadedProduct.id as String,
                    child: Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 400,
              width: 410,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loadedProduct.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rp ${loadedProduct.price.toStringAsFixed(3)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          loadedProduct.description,
                          style: TextStyle(
                              fontSize: 14, letterSpacing: 1, wordSpacing: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              height: 45,
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {
                                    cart.addItem(
                                        loadedProduct.id!,
                                        loadedProduct.price,
                                        loadedProduct.title,
                                        loadedProduct.imageUrl);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Added Item to Cart!',
                                      ),
                                      duration: Duration(seconds: 5),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          cart.removeSingleItem(
                                              loadedProduct.id!);
                                        },
                                      ),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink.shade100,
                                      foregroundColor: Colors.black),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.shopping_cart),
                                      Text('Add To Cart'),
                                    ],
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
