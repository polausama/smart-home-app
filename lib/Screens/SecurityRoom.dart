import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Components/RoundedButton.dart';
import 'package:smart_home_version2/Components/TextFieldContainer.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';


class SecurityRoom extends StatelessWidget {
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => SmartHomeCubit()..receiveData("sensors.state"),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
        listener: (context, state) {
          if(state is GatStates){
            SmartHomeCubit.getcubit(context).receiveData("sensors.state");
          }
        },
        builder: (context, state) {
          var myCubit = SmartHomeCubit.getcubit(context);
          return StreamBuilder(
          stream: myCubit.shareStream.stream,
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              data = data.split(" ");
              // print( data[22]+" "+data[23]);
              return Container(
                width: double.infinity,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      data[23]=="1"?Icons.lock_open:Icons.lock,
                      color: Colors.pinkAccent,
                      size: 60,
                    ),
                    TextFieldContainer(
                      child: TextField(
                        controller: password,
                        obscureText: true,
                      ),
                    ),
                    RoundedButton(
                      color: KBottomNavColor,
                      text: 'Confirm',
                      press: () {
                        print(password.text);
                        myCubit.toggleSecurityDoor(data[23], {"password_security":password.text});
                      },
                    )
                  ],
                ),
              ); 
            }else{
              return Center(child: CircularProgressIndicator());

            }
          }
          );
        },
      ),
    );
  }
}
