import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/firebase_options.dart';
import 'package:tkecommerce/observer/bloc_observer.dart';
import 'package:tkecommerce/repositories/local_storage/local_storage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
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
          create: (context) => WishlistBloc(
            localStorageRepository: LocalStorageRepository(),
          )..add(
              StartWishlist(),
            ),
        ),
        BlocProvider(
          create: (context) => CartBloc()
            ..add(
              LoadCart(),
            ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(
              LoadProducts(),
            ),
        ),
        BlocProvider(
          create: (context) => PaymentBloc()
            ..add(
              LoadPaymentMethod(),
            ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            paymentBloc: context.read<PaymentBloc>(),
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
