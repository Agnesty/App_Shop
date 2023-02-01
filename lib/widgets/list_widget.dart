import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products_provider.dart';
import 'item_tabBarView.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    
    return ScrollSnapList(
      onItemFocus: ((index) {}),
      dynamicItemSize: true,
      itemSize: 280,
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ItemTabBarView(
          // id: products[index].id!, 
          // imageUrl: products[index].imageUrl, 
          // price: products[index].price, 
          // title: products[index].title,
          ),
          ),
    );
  }
}