import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';

import 'ScreensComponents/myContainer.dart';

class StatusPage extends StatelessWidget {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SmartHomeCubit()..receiveData("sensors.state"),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
        listener: (context, states) {},
        builder: (context, states) {
          var myCubit = SmartHomeCubit.getCubit(context);

          var size = MediaQuery.of(context).size;
          return StreamBuilder(
            stream: myCubit.shareStream.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                data = data.split(" ");
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        child: Image.asset(
                          "assets/images/smart home logo 1 (1)-modified.png",
                          height: size.height * 0.3,
                          width: size.width * 0.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: myContainer(
                              myChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons8-temperature-inside-96.png",
                                    height: size.height * 0.06,
                                    width: size.width * 0.5,
                                  ),
                                  Text(
                                    'Temperature',
                                    style: kTextStyle,
                                  ),
                                  Text(
                                    data[1],
                                    style: kTextStyle,
                                  )
                                ],
                              ),
                              backGround: kAppBackGround,
                            ),
                          ),
                          Expanded(
                            child: myContainer(
                              myChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons8-temperature-96.png",
                                    height: size.height * 0.06,
                                    width: size.width * 0.5,
                                  ),
                                  Text(
                                    'Humidity',
                                    style: kTextStyle,
                                  ),
                                  Text(
                                    data[3],
                                    style: kTextStyle,
                                  )
                                ],
                              ),
                              backGround: kAppBackGround,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: myContainer(
                              myChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      "assets/images/icons8-rain-96.png",
                                    height: size.height * 0.06,
                                    width: size.width * 0.5,
                                  ),
                                  Text(
                                    'Raining',
                                    style: kTextStyle,
                                  ),
                                  Text(
                                    data[5],
                                    style: kTextStyle,
                                  )
                                ],
                              ),
                              backGround: kAppBackGround,
                            ),
                          ),
                          Expanded(
                            child: myContainer(
                              myChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons8-fire-80.png",
                                    height: size.height * 0.06,
                                    width: size.width * 0.5,
                                  ),
                                  Text(
                                    'Fire',
                                    style: kTextStyle,
                                  ),
                                  Text(
                                    data[7],
                                    style: kTextStyle,
                                  )
                                ],
                              ),
                              backGround: kAppBackGround,
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
