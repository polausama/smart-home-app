import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isolate_http/isolate_http.dart';
import 'package:smart_home_version2/Screens/DoorsController.dart';
import 'package:smart_home_version2/Screens/LightController.dart';
import 'package:smart_home_version2/Screens/SecurityRoom.dart';
import 'package:smart_home_version2/Screens/StatusPage.dart';


import '../DioHelper.dart';
import 'SmartHomeStates.dart';




class SmartHomeCubit extends Cubit<SmartHomeState> {
  SmartHomeCubit() : super(InitialState());
  StreamController shareStream = StreamController.broadcast();
  int myIndex = 1;
  List myAppBarList = [
    'Doors Controller',
    'Status Page',
    'Lights Controller',
    'Security Room',
  ];
  List myPages = [

    DoorsController(),
    StatusPage(),
    LightController(),
    SecurityRoom(),
  ];
  var isPassword = [true, true, true];
  void togglePassword(int index) {
    isPassword[index] = !isPassword[index];
    emit(TogglePasswordState());
  }

  void changeIndex(int index) {
    myIndex = index;
    emit(BottomNavigationBarStateIndexChanged());
  }
  toggleLights(int lightIndex,String data) {
    if (data == "0") {
      emit(LightStateOn());
      setControl("room${lightIndex+1}.light.on");
    } else {
      emit(LightStateOff());
      setControl("room${lightIndex+1}.light.off");
    }
  }

    static SmartHomeCubit getcubit(context) {
    return BlocProvider.of(context);
  }

  void setControl(String url){
    emit(LoadingStates());
    DioHelper.getData(url).then((value) {
      print(value.toString());
      emit(PostStates());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorStates());
    });
  }
  void sendData(String url,Map<String,dynamic> query){
    emit(LoadingSendingStates());
    DioHelper.postData(url, query).then((value) {
      print(value);
      emit(GatStates());
    }).catchError((onError){
      emit(ErrorSendingStates());
    });
  }
  static SmartHomeCubit getCubit(context){
    return BlocProvider.of(context);
  }

  void receiveData(String url)async{

    emit(LoadingReceivingStates());
    DioHelper.getData(url).then((value) {
      shareStream.add(value.toString());
      emit(ReceivingStates());
    }).catchError((onError){
      emit(ErrorReceivingStates());
    });
  }
  void toggleSecurityDoor(String data,Map<String,dynamic> query){
    if(data== "1"){
      sendData("close.security.room",query);
    }else{
      sendData("open.security.room",query);
    }
  }
  void toogleMainDoor(String doorName,String data){
    if(doorName== "main"){
      if(data == "1"){
        setControl("main.servo.off");
      }else{
        setControl("main.servo.on");
      }
    }else if(doorName== "window"){
      if(data == "1"){
        setControl("window.servo.off");
      }else{
        setControl("window.servo.on");
      }
    }else if(doorName== "garage"){
      if(data == "1"){
        setControl("garage.servo.off");
      }else{
        setControl("garage.servo.on");
      }
    }
  }
  void signupWithFireBase(String email,String password){
    emit(SignupLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      emit(SignupSuccessStates());
    }).onError((error, stackTrace) {
      emit(SignupErrorStates());
      print("error:${error.toString()}");
    });
  }
  void loginWithFireBase(String email,String password){
    emit(LoginLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(LoginSuccessStates());
    }).onError((error, stackTrace) {
      emit(LoginErrorStates());
      print("error:${error.toString()}");
    });
  }
}
