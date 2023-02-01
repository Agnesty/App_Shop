import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  final String title;
  Widget? child;
  
 AppBarContent({this.child, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              IconButton(onPressed: () {
                Scaffold.of(context).openDrawer();
              }, icon: Icon(Icons.menu_outlined)),
               Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: child,),
              
            ],
          ),
        ),
        // Divider(
        //   thickness: 2,
        //   indent: 25,
        //   endIndent: 25,
        // )
      ],
    );
  }
}
