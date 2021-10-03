import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: ScreenUtil().setWidth(150),
              color: Colors.red,
              child: Column(
                children: [],
              ),
            ),
          ),
          Positioned(
            right: -ScreenUtil().setWidth(50),
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffededed),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
              ),
              width: ScreenUtil().setWidth(375),
              height: double.infinity,
              child: Column(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
