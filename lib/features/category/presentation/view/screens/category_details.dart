import 'package:flutter/material.dart';
import 'package:news_app/features/category/presentation/view_model/category_provider.dart';
import 'package:news_app/features/category/model/category_model.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utilites/styles/app_colors.dart';
import '../../../../home_screen/presentation/view/widgets/tabs/tab_widget.dart';

class CategoryDetails extends StatefulWidget {
  CategoryModel category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryProvider provider = CategoryProvider();

  @override
  void initState() {
    super.initState();
    provider.getSources(
      widget.category.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => provider,
        child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
          if (categoryProvider.errorMessage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(categoryProvider.errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      categoryProvider.getSources(widget.category.id);
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          } else if (categoryProvider.sourcesList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else {
            return TabWidget(sourceList: categoryProvider.sourcesList!);
          }
        }));
  }
}
