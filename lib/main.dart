import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oila_market/bloc/bag_bloc/bag_cubit.dart';
import 'package:oila_market/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:oila_market/bloc/home_bloc/home_cubit.dart';
import 'package:oila_market/data/local/database/database.dart';
import 'package:oila_market/data/local/database/database_service.dart';
import 'package:oila_market/ui/screens/splash/splash_screen.dart';

late final AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();

  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<BagCubit>(create: (_) => BagCubit(database.bagDao)),
        BlocProvider<FavoriteCubit>(
            create: (_) => FavoriteCubit(database.favoriteDao)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Oila Market",
        home: const SplashScreen(),
      ),
    );
  }
}
