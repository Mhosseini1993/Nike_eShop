import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Enums.dart';
import 'package:nike/Screens/Login/bloc/auth_bloc.dart';
import 'package:nike/Screens/MainScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisiblePassword = true;
  AuthScreenMode screenMode = AuthScreenMode.SIGNIN;
  StreamSubscription<AuthState>? stateSubscription;
  final TextEditingController txtEmail =
      TextEditingController();
  final TextEditingController txtPassword =
      TextEditingController();

  @override
  void dispose() {
    stateSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocProvider<AuthBloc>(
      create: (BuildContext context) {
        final AuthBloc bloc = AuthBloc(authRepository, screenMode);
        stateSubscription = bloc.stream.listen((AuthState state) {
          if (state is AuthSucess) {
            //Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const MainScreen()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.exception.message)));

          }
        });
        return bloc;
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondary,
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (AuthState previousState, AuthState currentState) {
              return currentState is AuthInitial ||
                  currentState is AuthLoading ||
                  currentState is AuthError;
            },
            builder: (BuildContext context, AuthState state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/nike_logo.png',
                        color: Colors.white,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'خوش آمدید',
                        style: TextStyle(
                            fontSize: 20,
                            color: theme.colorScheme.onBackground),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.screenMode == AuthScreenMode.SIGNIN
                            ? 'لطفا وارد حساب کاربری خود شوید'
                            : 'ایمیل و رمز عبور خود را جهت ثبت نام وارد کنید',
                        style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onBackground),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: txtEmail,
                        decoration: const InputDecoration(
                            label: Text(
                              'آدرس ایمیل',
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: txtPassword,
                        decoration: InputDecoration(
                          label: const Text(
                            'رمز عبور',
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () {
                                isVisiblePassword = !isVisiblePassword;
                              },
                            ),
                            icon: Icon(
                              isVisiblePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: theme.colorScheme.onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isVisiblePassword,
                        obscuringCharacter: '*',
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              theme.colorScheme.onBackground),
                          foregroundColor: MaterialStateProperty.all(
                              theme.colorScheme.secondary),
                          minimumSize:
                              MaterialStateProperty.all(Size.fromHeight(56)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                              AuthButtonClicked(
                                  txtEmail.text, txtPassword.text));
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator()
                            : Text(state.screenMode == AuthScreenMode.SIGNIN
                                ? 'ورود'
                                : 'ثبت نام'),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.screenMode == AuthScreenMode.SIGNIN
                                ? 'حساب کاربری ندارید؟'
                                : 'وارد حساب کاربریتان شوید',
                            style: theme.textTheme.caption,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(AuthModeChanged());
                            },
                            child: Text(
                              state.screenMode == AuthScreenMode.SIGNIN
                                  ? 'ثبت نام'
                                  : 'ورود',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
