import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/appbar_content.dart';
import 'package:shop_app/widgets/favorite_item.dart';
import 'package:shop_app/widgets/item_tabBarView.dart';

class FavoriteScreen extends StatelessWidget {
  
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<ProductsProvider>(context);
    final prodFavorite = prodData.favoriteItems;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorite Items',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                  ],
                )),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prodFavorite.isEmpty)
                Center(
                  child: Text('Belum Ditambahkan'),
                ),
              if (prodFavorite.isNotEmpty)
                Container(
                  height: 500,
                  width: double.maxFinite,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: prodFavorite.length,
                      itemBuilder: (context, index) => FavoriteItems(
                        id: prodFavorite[index].id!, 
                        imageUrl: prodFavorite[index].imageUrl, 
                        title: prodFavorite[index].title,
                      )),
                ),
            ],
          )),
    );
  }
}
