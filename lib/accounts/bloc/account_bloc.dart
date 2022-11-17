import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:auth/accounts/accounts.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    // TODO: register on<AccountFetched> event
    on<AccountFetched>(_onAccountFetched);
  }

  Future<void> _onAccountFetched(
      AccountFetched event, Emitter<AccountState> emit) async {}
}
