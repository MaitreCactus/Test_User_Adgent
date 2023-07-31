import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformScaffold extends StatelessWidget {
  final ObstructingPreferredSizeWidget? iosAppBar;
  final PreferredSizeWidget? androidAppBar;
  final Widget body;


  const PlatformScaffold({super.key, this.iosAppBar, this.androidAppBar, required this.body});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: androidAppBar,
        body: body,
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: iosAppBar,
        child: body,
      );

    }
  }
}
