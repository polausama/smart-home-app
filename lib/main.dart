import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Components/Constants.dart';
import 'Cubit/BlocObserver.dart';
import 'DioHelper.dart';
import 'HomePage.dart';
import 'LoginAndSignPages/LogInPage.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle (
    SystemUiOverlayStyle(
      statusBarColor: kAppBarColor,
    ),
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      centerTitle: true,
      color: kAppBarColor,
    )),
    home: HomePage(),
  ));
}
