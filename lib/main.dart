import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_cubit.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:oila_market/bloc/home_bloc/home_cubit.dart';
import 'package:oila_market/data/local/database/database_service.dart';
import 'package:oila_market/model/favorite_model.dart';
import 'package:oila_market/ui/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) async =>
          FavoriteModel(likeDao: await DatabaseService.getLikeDao()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<BagCubit>(create: (_) => BagCubit()),
        BlocProvider<FavoriteCubit>(create: (_) => FavoriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Oila Market",
        home: const SplashScreen(),
      ),
    );
  }
}
