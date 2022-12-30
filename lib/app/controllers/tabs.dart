import 'package:riverpod/riverpod.dart';

enum TabType { accountView, settings, creation }

class TabNotifier extends StateNotifier<TabType> {
  TabNotifier() : super(TabType.accountView);

  void switchTab(TabType type) {
    state = type;
  }

  void switchTabWithIndex(int index) {
    switch (index) {
      case 0:
        return switchTab(TabType.accountView);
      case 1:
        return switchTab(TabType.creation);
      case 2:
        return switchTab(TabType.settings);
      default:
        throw UnimplementedError("Invalid tab given $index");
    }
  }
}

final tabProvider = StateNotifierProvider<TabNotifier, TabType>((ref) {
  return TabNotifier();
});

String appBarTitle(TabType type) {
  switch (type) {
    case TabType.accountView:
      return "Accounts";
    case TabType.creation:
      return "Add an Account";
    case TabType.settings:
      return "Settings";
  }
}
