import 'package:flutter/material.dart';
import 'package:news_app/core/utilites/styles/app_colors.dart';
import 'package:news_app/features/home_screen/data/models/Sources.dart';
import 'package:news_app/features/home_screen/presentation/view/widgets/news_widget.dart';
import 'package:news_app/features/home_screen/presentation/view/widgets/tabs/tab_item.dart';

class TabWidget extends StatefulWidget {
  List<Source> sourceList;

  TabWidget({super.key, required this.sourceList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              isScrollable: true,
              indicatorColor: AppColors.transparent,
              tabs: widget.sourceList
                  .map((source) => TabItem(
                      isSelected:
                          selectedIndex == widget.sourceList.indexOf(source),
                      source: source))
                  .toList()),
          Expanded(child: NewsWidget(source: widget.sourceList[selectedIndex]))
        ],
      ),
    );
  }
}
