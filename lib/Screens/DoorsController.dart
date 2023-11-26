import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';

import 'ScreensComponents/myContainer.dart';

class DoorsController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) =>
          SmartHomeCubit()..receiveData("sensors.state"),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
        listener: (context, state) {
          if (state is PostStates) {
            SmartHomeCubit.getcubit(context).receiveData("sensors.state");
          }
        },
        builder: (context, state) {
          var myCubit = SmartHomeCubit.getcubit(context);
          var size = MediaQuery.of(context).size;
          return StreamBuilder(
            stream: myCubit.shareStream.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                data = data.split(" ");
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                myCubit.toogleMainDoor("main", data[19]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data[19] == "1"
                                        ? Image.asset(
                                            'assets/images/Main Door open.png',
                                            height: size.height * 0.3,
                                          )
                                        : Image.asset(
                                            'assets/images/Main Door close.png',
                                            height: size.height * 0.3,
                                          ),
                                  ],
                                ),
                                backGround: kAppBackGround,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                myCubit.toogleMainDoor("window", data[17]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data[17] == "1"
                                        ? Image.asset(
                                            'assets/images/Window close.png',
                                            height: size.height * 0.3,
                                          )
                                        : Image.asset(
                                            'assets/images/Window open.png',
                                            height: size.height * 0.3,
                                          ),
                                    // windowIcon,
                                  ],
                                ),
                                backGround: kAppBackGround,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                myCubit.toogleMainDoor("garage", data[21]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data[21] == "1"
                                        ? Image.asset(
                                            'assets/images/Garage Open.png',
                                            height: size.height*0.3,
                                            width: size.width,
                                          )
                                        : Image.asset(
                                            'assets/images/Garage Close.png',
                                            height: size.height*0.3,
                                            width: size.width,
                                          ),
                                  ],
                                ),
                                backGround: kAppBackGround,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
