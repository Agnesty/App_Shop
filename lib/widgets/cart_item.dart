import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String image;

  const CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.image,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: <Widget>[
                    TextButton(onPressed: () {
                      Navigator.of(context).pop(false);
                    }, child: Text('No')),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop(true);
                    }, child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  height: 65,
                  width: 65,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
            ),
            title: Text(title),
            subtitle:
                Text('Harga : Rp ${(price * quantity).toStringAsFixed(3)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
