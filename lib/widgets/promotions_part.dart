import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/promotions_provider.dart';

class PromotionsPart extends StatelessWidget {
  const PromotionsPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final promoData = Provider.of<PromotionsProducts>(context, listen: false);
     final promo = promoData.promoItem;
    return Scaffold(
      body: ListView.builder(
        itemCount: promo.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Card(
            elevation: 7,
            child: Container(
              height: 150,
              width: 250,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 180,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/Agnesty_Portf_App.png'),
                      image: NetworkImage(promo[index].imageUrl),
                      fit: BoxFit.cover,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text(promo[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(promo[index].description, style: TextStyle(color: Colors.grey, fontSize: 14),),
                    SizedBox(height: 8,),
                    Text('YOU GET THIS!', style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Card(
                      elevation: 3,
                      color: Colors.pink.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Discount ${promo[index].discount.toString()}%'),
                      ))
              
                ]),
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
