import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/blocs_shelf.dart';
import 'package:tkecommerce/config/config_shelf.dart';
import 'package:tkecommerce/firebase_options.dart';
import 'package:tkecommerce/observer/bloc_observer.dart';
import 'package:tkecommerce/repositories/repositories.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //How to define Blocs
    return MultiBlocProvider(
      providers: [
        //Bloc Defination with Default Event
        BlocProvider(
          create: (context) => WishlistBloc()..add(StartWishlist()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(LoadCart()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(productRepository: ProductRepository())
                ..add(
                  LoadProducts(),
                ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'TKECOMMERCE',
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
