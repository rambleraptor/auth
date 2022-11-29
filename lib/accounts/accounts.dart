import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account(
      {required this.secret, required this.website, required this.username});
  final String secret;
  final String website;
  final String username;

  @override
  List<Object> get props => [secret, website, username];
}
