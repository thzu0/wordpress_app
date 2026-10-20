import 'package:flutter/material.dart';
import 'package:wordpress_app/constans/constans.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  const CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Constants.primaryColor.withValues(alpha: 0.15),
            ),
            child: Icon(Icons.close, color: Constants.primaryColor),
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              color: Constants.primaryColor,
              fontFamily: 'Lalezar',
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
