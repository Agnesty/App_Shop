import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/appbar_content.dart';

import '../providers/order_provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
        _isLoading = true;
      Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
      setState(() {
        _isLoading = false;
      });

      });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            child: AppBarContent(
              title: 'Your Orders',
            ),
          ),
        ),
        // PreferredSize(
        //   preferredSize: const Size.fromHeight(70),
        //   child: Container(
        //       padding: EdgeInsets.only(left: 10),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               IconButton(
        //                   onPressed: () {
        //                     Scaffold.of(context).openDrawer();
        //                   },
        //                   icon: Icon(Icons.menu)),
        //               const Text(
        //                 'Your Orders',
        //                 style:
        //                     TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //           const Divider(
        //             thickness: 2,
        //           ),
        //         ],
        //       )),
        // ),
        drawer: const AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (context, index) => OrdersItem(
                      orders: ordersData.orders[index],
                    )));
  }
}
