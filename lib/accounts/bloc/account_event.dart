part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountFetched extends AccountEvent {}
