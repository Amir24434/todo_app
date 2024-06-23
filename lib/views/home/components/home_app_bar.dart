// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/constants.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({
    super.key,
    required this.drawerKey,
  });
  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController animateController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animateController.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        animateController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animateController,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () {
                  base.isEmpty
                      ? noTaskWarning(context)
                      : deleteAllTask(context);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
