import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/images/controllers/views/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountImage extends ConsumerStatefulWidget {
  const AccountImage({super.key, required this.account});

  final Account account;

  @override
  AccountImageState createState() => AccountImageState();
}

class AccountImageState extends ConsumerState<AccountImage> {
  late final ImageFileController controller;
  @override
  void initState() {
    super.initState();
    controller = ImageFileController(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<String> path = ref.watch(controller.provider);
    return path.when(
      loading: () => Container(),
      error: (err, stack) => Container(),
      data: (path) => SvgPicture.asset(path),
    );
  }
}
