import 'package:auth/accounts/view/account_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const AuthApp());
}

class AuthApp extends MaterialApp {
  const AuthApp({super.key}) : super(home: const AccountsPage());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
