import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/images/controllers/views/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AccountImage extends StatelessWidget {
  const AccountImage({super.key, required this.account});

  final Account account;
  @override
  Widget build(BuildContext context) {
    final ImageFileController controller = ImageFileController();

    return ChangeNotifierProvider(
      create: (context) => controller,
      child: _AccountImageConsumer(account: account, controller: controller),
    );
  }
}

class _AccountImageConsumer extends StatefulWidget {
  const _AccountImageConsumer(
      {required this.account, required this.controller});

  final Account account;
  final ImageFileController controller;

  @override
  State<_AccountImageConsumer> createState() => _AccountImageConsumerState();
}

class _AccountImageConsumerState extends State<_AccountImageConsumer> {
  @override
  void initState() {
    super.initState();
    widget.controller.findPath(widget.account.issuer);
  }

  @override
  Widget build(BuildContext buildContext) {
    return Consumer<ImageFileController>(
      builder: (context, value, child) =>
          SvgPicture.asset(widget.controller.path()),
      child: Container(),
    );
  }
}
