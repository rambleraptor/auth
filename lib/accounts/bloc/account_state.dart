part of 'account_bloc.dart';

enum AccountStatus { initial, success, failure }

class AccountState extends Equatable {
  const AccountState({
    this.status = AccountStatus.initial,
    this.accounts = const<Account>[],
    this.hasReachedMax = false,
  })

  final AccountStatus status;
  final List<Account> accounts;
  final bool hasReachedMax;

  AccountState copyWith({
    AccountStatus? status,
    List<Account>? accounts,
    bool? hasReachedMax,
  }) {
    return AccountState(status: status ?? this.status, accounts: accounts ?? this.accounts, hasReachedMax: hasReachedMax ?? this.hasReachedMax)
  }

    @override
  String toString() {
    return '''AccountState { status: $status, hasReachedMax: $hasReachedMax, accounts: ${accounts.length} }''';
  }

  @override
  List<Object> get props => [status, accounts, hasReachedMax];

}