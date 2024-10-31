
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';

Widget cusAppBarCircle(BuildContext context,{required String title}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding:const EdgeInsets.all(10),
          decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color:Styles.colorF9F9F9.withOpacity(0.8)
          ),
          child: const Icon(Icons.arrow_back,color: Styles.nearPrimary,),
        ),
      ),
      const Spacer(),
      Container(
        padding:const EdgeInsets.all(10),
        decoration:  const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5))
        ),
        child: Text(title,style: context.theme.textTheme.headlineLarge?.copyWith(
            color: Styles.nearPrimary,fontWeight: FontWeight.bold
        ),),
      ),
      const Spacer(),
    ],
  );
}
