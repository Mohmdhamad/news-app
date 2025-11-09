import 'package:flutter/material.dart';
import 'package:news_app/features/home_screen/data/models/Sources.dart';
import 'package:news_app/features/home_screen/presentation/view/widgets/news_item.dart';
import 'package:news_app/features/home_screen/presentation/view_model/news_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utilites/styles/app_colors.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController scrollController = ScrollController();
  late NewsProvider newsProvider;

  @override
  void initState() {
    super.initState();
    newsProvider = NewsProvider();
    newsProvider.getNewsBySourceId(widget.source.id ?? '');
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        newsProvider.loadMoreNews(widget.source.id ?? '');
      }
    });
  }

  @override
  void didUpdateWidget(NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.source.id != oldWidget.source.id) {
      newsProvider.getNewsBySourceId(widget.source.id ?? '');
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: newsProvider,
        child: Consumer<NewsProvider>(builder: (context, newsProvider, child) {
          if (newsProvider.errorMessage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(newsProvider.errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blueColor)),
                    onPressed: () {
                      newsProvider.getNewsBySourceId(widget.source.id ?? '');
                    },
                    child: Text("Try Again",
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            );
          }
          if (newsProvider.newsList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLightColor,
              ),
            );
          } else {
            return ListView.builder(
                controller: scrollController,
                itemCount: newsProvider.newsList!.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: newsProvider.newsList![index]);
                });
          }
        }));
  }
}
