import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final navigationControllerProvider = StateProvider<CircularBottomNavigationController>((ref) {
//   return CircularBottomNavigationController(0); // Initialize with the default value.
// });
final valueProvider = StateProvider<int>((ref) {
  return 0;
});

class BottemBar extends ConsumerStatefulWidget {
  const BottemBar({super.key});

  @override
  ConsumerState createState() => _BottemBarState();
}

class _BottemBarState extends ConsumerState<BottemBar> {
  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.blue,
        labelStyle: const TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.search, "Search", Colors.orange,
        labelStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.layers, "Reports", Colors.red,
        circleStrokeColor: Colors.black),
    TabItem(Icons.notifications, "Notifications", Colors.cyan),
  ]);

  final CircularBottomNavigationController navigationController =
      CircularBottomNavigationController(0);

  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      tabItems,
      selectedCallback: (int? selectedPos) {
        ref.read(valueProvider.notifier).state = selectedPos!;
      },
      controller: navigationController,
    );
  }
}
