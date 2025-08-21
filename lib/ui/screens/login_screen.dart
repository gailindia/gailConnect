// Created By Amit Jangid 24/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/logo_widget.dart';
import 'package:multiutillib/animations/fade_animation.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/login_controller.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../styles/color_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();

  @override
  void initState() {
    callController();
    super.initState();
  }

  callController() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    print("callController init");

    loginController.userIdController.text =
        (await pref.getString("userName", isEncrypted: true)) ?? "";
    loginController.passwordController.text =
        (await pref.getString("password", isEncrypted: true)) ?? "";
    print(
        "callController after valeue ${loginController.userIdController} ** ${loginController.passwordController}");
  }

  @override
  Widget build(BuildContext context) {
    final ColorController colorController = Get.put(ColorController());
    final _height = MediaQuery.of(context).size.height;
    callController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.1, 0.7],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  colorController.kPrimaryColor,
                  // ignore: unnecessary_const
                  colorController.kPrimaryDarkColor,
                ],
              ),
            ),
            height: _height * 1,
            child: Column(
              children: [
                GetBuilder<ColorController>(
                    id: kLogin,
                    builder: (colorController) {
                      return GetBuilder<LoginController>(
                        id: kLogin,
                        builder: (_loginController) => Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FadeAnimation(
                                  delay: 1.6,
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 100),
                                    child:
                                        Center(child: LogoWidget(width: 110)),
                                  ),
                                ),
                                FadeAnimation(
                                  delay: 2.2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('$kWelcomemsg',
                                          style: textStyle18Bold.copyWith(
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  delay: 2.2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('$kSignIn',
                                          style: textStyle14Bold.copyWith(
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  delay: 2.4,
                                  child: TextFormField(
                                    // contextMenuBuilder: null,
                                    autocorrect: false,

                                    focusNode: _loginController.userIdFocusNode,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller:
                                        _loginController.userIdController,
                                    onSaved: (_userId) =>
                                        _loginController.userId = _userId!,
                                    validator: (_userId) => _userId!.isEmpty
                                        ? kMsgUserIdRequired
                                        : null,
                                    // onTap: () => _loginController.requestFocus(
                                    //   context: context,
                                    //   focusNode: _loginController.userIdFocusNode,
                                    // ),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusColor:
                                            colorController.kPrimaryDarkColor,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: colorController
                                                  .kPrimaryDarkColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        labelText: kUserId,
                                        hintText: kEnterUserId,
                                        prefixIcon: Icon(
                                          Feather.user,
                                          color: _loginController
                                                  .userIdFocusNode.hasFocus
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        labelStyle: TextStyle(
                                          color: _loginController
                                                  .userIdFocusNode.hasFocus
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        hintStyle: TextStyle(
                                          color: _loginController
                                                  .userIdFocusNode.hasFocus
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        errorStyle: TextStyle(
                                            color: colorController.kBlackColor),
                                        errorBorder: OutlineInputBorder(
                                          // ignore: prefer_const_constructors
                                          borderSide: BorderSide(
                                              color:
                                                  colorController.kBlackColor),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          //<-- SEE HERE
                                        )),
                                  ),
                                ),
                                verticalSpace24,
                                FadeAnimation(
                                  delay: 2.6,
                                  child: Obx(
                                    () => TextFormField(
                                      contextMenuBuilder: null,
                                      autocorrect: false,

                                      obscureText:
                                          !_loginController.showPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      focusNode:
                                          _loginController.passwordFocusNode,
                                      controller:
                                          _loginController.passwordController,
                                      onSaved: (_password) => _loginController
                                          .password = _password!,
                                      validator: (_password) =>
                                          _password!.isEmpty
                                              ? kMsgPasswordRequired
                                              : null,
                                      // onTap: () => _loginController.requestFocus(
                                      //   context: context,
                                      //   focusNode: _loginController.passwordFocusNode,
                                      // ),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // ignore: prefer_const_constructors
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0),

                                            //<-- SEE HERE
                                          ),
                                          focusColor:
                                              colorController.kPrimaryDarkColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: colorController
                                                    .kPrimaryDarkColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: kPassword,
                                          hintText: kEnterPassword,
                                          prefixIcon: Icon(
                                            MaterialCommunityIcons.lock_outline,
                                            color: _loginController
                                                    .passwordFocusNode.hasFocus
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          suffixIcon: IconButton(
                                            color: _loginController
                                                    .passwordFocusNode.hasFocus
                                                ? Colors.white
                                                : Colors.black,
                                            onPressed: () => _loginController
                                                    .showPassword =
                                                !_loginController.showPassword,
                                            icon: Icon(
                                              _loginController.showPassword
                                                  ? MaterialCommunityIcons
                                                      .eye_off
                                                  : MaterialCommunityIcons.eye,
                                            ),
                                          ),
                                          labelStyle: TextStyle(
                                            color: _loginController
                                                    .passwordFocusNode.hasFocus
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          hintStyle: TextStyle(
                                            color: _loginController
                                                    .passwordFocusNode.hasFocus
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          errorStyle: TextStyle(
                                              color:
                                                  colorController.kBlackColor),
                                          errorBorder: OutlineInputBorder(
                                            // ignore: prefer_const_constructors
                                            borderSide: BorderSide(
                                                color: colorController
                                                    .kBlackColor),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            //<-- SEE HERE
                                          )),
                                    ),
                                  ),
                                ),
                                verticalSpace12,
                                FadeAnimation(
                                  delay: 2.8,
                                  child: PrimaryButton(
                                    text: kLogin,
                                    elevation: 8,
                                    width: double.infinity,
                                    btnColor: colorController.kPrimaryDarkColor,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        // calling authenticate user method
                                        _loginController.authenticateUser(
                                            context: context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
