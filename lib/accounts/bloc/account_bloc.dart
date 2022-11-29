import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:auth/accounts/accounts.dart';
import 'package:equatable/equatable.dart';
import 'package:english_words/english_words.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    // TODO: register on<AccountFetched> event
    on<AccountFetched>(_onAccountFetched);
  }

  Future<void> _onAccountFetched(
      AccountFetched event, Emitter<AccountState> emit) async {
    if (state.status == AccountStatus.initial) {
      final accounts = _fetchDevAccounts(10);
      return emit(state.copyWith(status: AccountStatus.success, accounts: accounts, hasReachedMax: false))
    }

    final accounts = _fetchDevAccounts(10);
    return emit(state.copyWith(accounts: List.of(state.accounts)..addAll(accounts), status: AccountStatus.success, hasReachedMax: false))
  }

  List<Account> _fetchDevAccounts(int num) {
    return nouns
        .take(num)
        .map((word) => Account(secret: word, website: word, username: word))
        .toList();
  }
}
