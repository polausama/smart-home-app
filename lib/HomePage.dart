import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Components/Constants.dart';
import 'Cubit/SmartHomeCubit.dart';
import 'Cubit/SmartHomeStates.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SmartHomeCubit(),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var myCubit = SmartHomeCubit.getcubit(context);

          return Scaffold(
            backgroundColor: kAppBackGround,
            appBar: AppBar(
              title: Text(myCubit.myAppBarList[myCubit.myIndex]),
            ),
            body: myCubit.myPages[myCubit.myIndex],
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Icon(Icons.sensor_door_outlined), title: 'Doors Controller'),
                TabItem(
                    icon: Icon(Icons.cloud),
                    title: 'Status'),
                TabItem(
                    icon: Icon(Icons.lightbulb), title: 'Lights Controller'),
                TabItem(icon: Icon(Icons.lock), title: 'Security ')
              ],
              onTap: (index) {
                myCubit.changeIndex(index);
              },
              initialActiveIndex: myCubit.myIndex,
              backgroundColor: kAppBarColor,
            ),
          );
        },
      ),
    );
  }
}
