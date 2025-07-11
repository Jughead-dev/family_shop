import 'package:family_shop/bloc/bag_bloc/bag_cubit.dart';
import 'package:family_shop/bloc/detail_bloc/detail_cubit.dart';
import 'package:family_shop/bloc/home_bloc/home_cubit.dart';
import 'package:family_shop/model/favorite_model.dart';
import 'package:family_shop/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => FavoriteModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<BagCubit>(create: (_) => BagCubit()),
        BlocProvider<DetailCubit>(create: (_) => DetailCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Family Shop",
        home: const SplashScreen(),
      ),
    );
  }
}
