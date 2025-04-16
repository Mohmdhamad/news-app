import 'package:bloc/bloc.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/sports/sports_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_outlined),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_rounded),
      label: 'Sports',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    if (currentIndex == 2) {
      getScience();
    }
    emit(NewsBottomNavBarState());
  }

  List<Widget> screens = [BusinessScreen(), SportsScreen(), ScienceScreen()];
  List<dynamic> business = [];
  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(
          url: 'https://newsapi.org/v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'business',
            'apiKey': '5f1c414a85e24141b1b7c1a56f2ae6b9',
          },
        )
        .then((value) {
          business = value.data['articles'];
          print(business[0]['title']);
          emit(GetBusinessSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(GetBusinessErrorState(error.toString()));
        });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(GetSportsLoadingState());
    DioHelper.getData(
          url: 'https://newsapi.org/v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'sports',
            'apiKey': '5f1c414a85e24141b1b7c1a56f2ae6b9',
          },
        )
        .then((value) {
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(GetSportsSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(GetSportsErrorState(error.toString()));
        });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(GetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
            url: 'https://newsapi.org/v2/top-headlines',
            query: {
              'country': 'us',
              'category': 'science',
              'apiKey': '5f1c414a85e24141b1b7c1a56f2ae6b9',
            },
          )
          .then((value) {
            science = value.data['articles'];
            print(science[0]['title']);
            emit(GetScienceSuccessState());
          })
          .catchError((error) {
            print(error.toString());
            emit(GetScienceErrorState(error.toString()));
          });
    } else {
      emit(GetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(GetSearchLoadingState());
    DioHelper.getData(
          url: 'https://newsapi.org/v2/everything',
          query: {'q': value, 'apiKey': '5f1c414a85e24141b1b7c1a56f2ae6b9'},
        )
        .then((value) {
          search = value.data['articles'];
          print(search[0]['title']);
          emit(GetSearchSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(GetSearchErrorState(error.toString()));
        });
  }
}
