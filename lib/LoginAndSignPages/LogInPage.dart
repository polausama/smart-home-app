import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_version2/Components/BackGround.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Components/RoundedButton.dart';
import 'package:smart_home_version2/Components/TextFieldContainer.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';


import '../HomePage.dart';
import 'SignUpPage.dart';

class LogInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var logInFormKey = GlobalKey<FormState>();
  var currentUserEmail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SmartHomeCubit(),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
          listener: (context, state) {
            if(state is LoginSuccessStates){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return HomePage();
              }));
            }else if(state is LoginErrorStates){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cannot Login Enter valid data")));
            }
          },
          builder: (context, state) {
            var myCubit = SmartHomeCubit.getcubit(context);
            return Scaffold(
              // appBar: AppBar(
              //   title: Text('Log In'),
              // ),
              body: BackGround(
                child: Center(
                    child: Form(
                  key: logInFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          child: Image.asset("assets/images/smart home logo 1 (1)-modified.png",),
                        ),

                      TextFieldContainer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: kInButtonColor,
                            ),
                            hintText: 'enter your e-mail',
                            border: InputBorder.none,
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'enter valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          obscureText: myCubit.isPassword[0],
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: kInButtonColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  myCubit.togglePassword(0);
                                },
                                icon: Icon(
                                  myCubit.isPassword[0]
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kInButtonColor,
                                )),
                            hintText: 'enter your password',
                            border: InputBorder.none,
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return 'enter valid password';
                            }
                            return null;
                          },
                        ),
                      ),
                      RoundedButton(
                        text: 'Log In',
                        color: kInButtonColor,
                        press: () {
                          if (logInFormKey.currentState!.validate()) {
                            myCubit.loginWithFireBase(emailController.text, passwordController.text);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'if you dont have account click  ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              'here ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return SignUpPage();
                                }),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ),
            );
          }),
    );
  }
}
