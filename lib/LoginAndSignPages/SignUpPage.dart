import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_version2/Components/BackGround.dart';
import 'package:smart_home_version2/Components/Constants.dart';
import 'package:smart_home_version2/Components/RoundedButton.dart';
import 'package:smart_home_version2/Components/TextFieldContainer.dart';
import 'package:smart_home_version2/Cubit/SmartHomeCubit.dart';
import 'package:smart_home_version2/Cubit/SmartHomeStates.dart';
import '../HomePage.dart';
import 'LogInPage.dart';

class SignUpPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var SignUpformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SmartHomeCubit(),
      child: BlocConsumer<SmartHomeCubit, SmartHomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var myCubit = SmartHomeCubit.getcubit(context);
            return Scaffold(
              // appBar: AppBar(
              //   title: Text('Sign Up'),
              // ),
              body: BackGround(
                child: Center(
                    child: Form(
                  key: SignUpformKey,
                  child: SingleChildScrollView(
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
                            controller: eMailController,
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
                            obscureText: myCubit.isPassword[1],
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: kInButtonColor,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    myCubit.togglePassword(1);
                                  },
                                  icon: Icon(
                                    myCubit.isPassword[1]
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
                        TextFieldContainer(
                          child: TextFormField(
                            obscureText: myCubit.isPassword[2],
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: kInButtonColor,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    myCubit.togglePassword(2);
                                  },
                                  icon: Icon(
                                    myCubit.isPassword[2]
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kInButtonColor,
                                  )),
                              hintText: 're enter your password',
                              border: InputBorder.none,
                            ),
                            controller: rePasswordController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  passwordController.text !=
                                      rePasswordController.text) {
                                return 'the password is not identical';
                              }
                              return null;
                            },
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            obscureText: false,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: kInButtonColor,
                              ),
                              hintText: 'enter your number',
                              border: InputBorder.none,
                            ),
                            controller: phoneController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10) {
                                return 'enter valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                        RoundedButton(
                          text: 'Sign Up',
                          color: kInButtonColor,
                          press: () {
                            if (SignUpformKey.currentState!.validate()) {
                              myCubit.signupWithFireBase(eMailController.text, passwordController.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }),
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'if you  have an account click  ',
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
                                    return LogInPage();
                                  }),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
              ),
            );
          }),
    );
  }
}
