import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/login/login_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_text.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userNameController, _passwordController;
  bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.addListener(() {
      setState(() {
        enableSignIn = (_userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty);
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = (_userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_48.h),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_32.h),
                      child: Text(
                        TranslationConstants.welcomeBack.translate(context),
                        style: Theme.of(context).textTheme.welcomeHeadLine6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_4.h),
                      child: Text(
                        TranslationConstants.loginToMovieApp.translate(context),
                        style: Theme.of(context).textTheme.hintSubtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_24.h),
                      child: LoginTextField(
                          hintText: TranslationConstants.enterUsername
                              .translate(context),
                          controller: _userNameController),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_4.h),
                      child: LoginTextField(
                        hintText: TranslationConstants.enterPassword
                            .translate(context),
                        controller: _passwordController,
                        isPassword: true,
                      ),
                    ),
                    if (state is LoginError)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
                        child: Text(
                          state.message.translate(context),
                          style: Theme.of(context).textTheme.orangeSubtitle1,
                        ),
                      )
                    else
                      SizedBox(height: Sizes.dimen_10.h),
                    AppButton(
                      buttonTitle: TranslationConstants.loginToMovieApp
                          .translate(context),
                      onButtonPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(LoginToAppEvent(
                            userName: _userNameController.text,
                            password: _passwordController.text));
                      },
                      isButtonEnable: enableSignIn,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
                      child: Text(
                        TranslationConstants.or.translate(context),
                        style: Theme.of(context).textTheme.greySubtitle1,
                      ),
                    ),
                    AppButton(
                      buttonTitle:
                          TranslationConstants.guestSignIn.translate(context),
                      onButtonPressed: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(const LoginToAppEvent(isGuest: true));
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is LoginSuccess) {
            _navigateToHomeScreen();
          }
        },
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteList.HOME_SCREEN, (route) => false);
  }
}
