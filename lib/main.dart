import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/cubit/bloc_observer.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/cubit/theme_cubit.dart';
import 'package:news/shared/cubit/theme_states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'layout/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (BuildContext context) =>
                  AppCubit()..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(
          create:
              (BuildContext context) =>
                  NewsCubit()
                    ..getBusiness()
                    ..getSports(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: false,
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
                shape: CircleBorder(),
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                actionsIconTheme: IconThemeData(color: Colors.black54),
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0,
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrangeAccent,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 45.0,
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: false,
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
                shape: CircleBorder(),
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                actionsIconTheme: IconThemeData(color: Colors.white),
                color: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0,
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrangeAccent,
                unselectedItemColor: Colors.grey,
                elevation: 45.0,
                backgroundColor: HexColor('333739'),
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
