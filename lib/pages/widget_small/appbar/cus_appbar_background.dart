
import 'package:flutter/cupertino.dart';

import '../../../core/assets.dart';

Widget cusAppBarBackground(BuildContext context,{required Widget widget}){
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    height: 170,
    decoration: const BoxDecoration(
    ),
    child: Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset(Asset.bgImagePremium,fit: BoxFit.fitHeight,)),
        Padding(
          padding: const EdgeInsets.only(left: 10,bottom: 10,right: 10),
          child: widget
        ),
      ],
    ),
  );
}