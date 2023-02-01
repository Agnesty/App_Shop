import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem(
      {required this.id,
      required this.imageUrl,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldMsg = ScaffoldMessenger.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.pink.shade100,
                  )),
              IconButton(
                  onPressed: () async {
                    try {
                      await Provider.of<ProductsProvider>(context, listen: false)
                          .deleteProduct(id);
                    } catch (error) {
                      scaffoldMsg.showSnackBar(const SnackBar(
                          content: Text(
                        'Deleting failed',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
