import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/promotions_part.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/appbar_content.dart';
import '../widgets/badge.dart';
import '../widgets/list_widget.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //  Future.delayed(Duration.zero).then((_) {
    //  Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    //  });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            child: AppBarContent(
              title: 'ShopApp',
              child: Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                  value: cart.itemCount.toString(),
                  child: ch!,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            // Bagian Tab Bar
            Container(
              height: 50,
              width: double.maxFinite,
              child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  isScrollable: false,
                  indicator:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  splashBorderRadius: BorderRadius.circular(40),
                  controller: _tabController,
                  tabs: const [
                    Text(
                      'All Products',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('Promotions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ]),
            ),

            // Bagian Tab Bar View
            Container(
              height: 420,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                Container(
                  height: 280,
                  width: double.maxFinite,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const ListWidget(),
                ),
                Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: const Center(
                    child: PromotionsPart(),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
