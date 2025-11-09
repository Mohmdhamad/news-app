import 'package:flutter/material.dart';
import 'package:news_app/features/category/presentation/view/screens/category_details.dart';
import 'package:news_app/features/category/presentation/view/widgets/category_fragment.dart';
import 'package:news_app/features/category/model/category_model.dart';
import 'package:news_app/features/home_screen/presentation/view/widgets/home_drawer.dart';
import 'package:news_app/features/home_screen/presentation/view/widgets/news_search_delegate.dart';
import 'package:news_app/core/utilites/constants/app_assets.dart';
import 'package:news_app/core/utilites/styles/app_colors.dart';
import 'package:news_app/core/utilites/extentions/localization_extension.dart';

import '../../../../settings/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: AppColors.whiteColor,
            child: Image.asset(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                AppAssets.background),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                selectSideMenuItem == HomeDrawer.settings
                    ? context.localization.settings
                    : selectedCategory == null
                        ? 'News App!'
                        : selectedCategory!.id,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: NewsSearchDelegate());
                    },
                    icon: Icon(
                      Icons.search,
                      size: 25,
                      color: AppColors.blackColor,
                    ))
              ],
            ),
            drawer: Drawer(
              child: HomeDrawer(
                onSideMenuItemClick: onSideMenuItemClick,
              ),
            ),
            body: selectSideMenuItem == HomeDrawer.settings
                ? SettingsTab()
                : selectedCategory == null
                    ? CategoryFragment(
                        onCategoryItemClick: onCategoryItemClick,
                      )
                    : CategoryDetails(
                        category: selectedCategory!,
                      ),
          )
        ],
      ),
    );
  }

  CategoryModel? selectedCategory;

  void onCategoryItemClick(CategoryModel newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }

  int selectSideMenuItem = HomeDrawer.categories;

  void onSideMenuItemClick(int newSideMenuItem) {
    selectSideMenuItem = newSideMenuItem;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
