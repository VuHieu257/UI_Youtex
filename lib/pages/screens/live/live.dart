import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Styles.blue,
        leading: null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Live',style: context.theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Center(child:Text("Chức năng đang được phát triển",
        style: context.theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),),),
    );
  }
}
