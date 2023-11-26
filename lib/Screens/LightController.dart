import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';

import 'ScreensComponents/myContainer.dart';


class LightController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => SmartHomeCubit()..receiveData("sensors.state"),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
        listener: (context, state) {
          if(state is PostStates){
            SmartHomeCubit.getcubit(context).receiveData("sensors.state");
          }
        },
        builder: (context, state) {
          var myCubit = SmartHomeCubit.getcubit(context);
          return StreamBuilder(
            stream: myCubit.shareStream.stream,
            builder: (BuildContext context,AsyncSnapshot snapshot){
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
                                myCubit.toggleLights(0,data[9]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      data[9]=="1"?FontAwesomeIcons.solidLightbulb:FontAwesomeIcons.lightbulb,
                                      color: Colors.pinkAccent,
                                      size: 80,
                                    ),
                                    Text(
                                      'Light One',
                                      style: kTextStyle,
                                    )
                                  ],
                                ),
                                backGround: kAppBackGround,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                myCubit.toggleLights(1,data[11]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      data[11]=="1"?FontAwesomeIcons.solidLightbulb:FontAwesomeIcons.lightbulb,
                                      color: Colors.lightGreenAccent,
                                      size: 80,
                                    ),
                                    Text('Light Two', style: kTextStyle)
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
                                myCubit.toggleLights(2,data[13]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      data[13]=="1"?FontAwesomeIcons.solidLightbulb:FontAwesomeIcons.lightbulb,
                                      color: Colors.pinkAccent,
                                      size: 80,
                                    ),
                                    Text('Light Three', style: kTextStyle)
                                  ],
                                ),
                                backGround: kAppBackGround,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                myCubit.toggleLights(3,data[15]);
                              },
                              child: myContainer(
                                myChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      data[15]=="1"?FontAwesomeIcons.solidLightbulb:FontAwesomeIcons.lightbulb,
                                      color: Colors.lightGreenAccent,
                                      size: 80,
                                    ),
                                    Text('Light Four', style: kTextStyle)
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
