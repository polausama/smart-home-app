import 'package:flutter/material.dart';

import 'Constants.dart';

class BackGround extends StatelessWidget {
  Widget? child;
  BackGround({this.child});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        color: kAppBackGround,
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              width: size.width * 0.4,
              child: Image.asset('assets/images/login_bottom.png'),
            ),
            child!,
          ],
        ));
  }
}
