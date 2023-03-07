import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/blocs/profile/profile_bloc.dart';
import 'package:tkecommerce/cubits/sign_in/sign_in_cubit.dart';
import 'package:tkecommerce/cubits/sign_up/sign_up_cubit.dart';
import 'package:tkecommerce/firebase_options.dart';
import 'package:tkecommerce/observer/bloc_observer.dart';

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

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //The way of defining multiple repositories
    return MultiRepositoryProvider(
      providers: [
        //Default defination of a repository
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocalStorageRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider(
          create: (context) => CategoryRepository(),
        ),
        RepositoryProvider(
          create: (context) => CheckoutRepository(),
        ),
      ], //How to define Multiple Blocs
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          //Bloc Defination with Default Event
          BlocProvider(
            create: (context) => WishlistBloc(
              localStorageRepository: context.read<LocalStorageRepository>(),
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
              categoryRepository: context.read<CategoryRepository>(),
            )..add(
                LoadCategories(),
              ),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
              productRepository: context.read<ProductRepository>(),
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
                checkoutRepository: context.read<CheckoutRepository>(),
                authBloc: context.read<AuthBloc>()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              productBloc: context.read<ProductBloc>(),
            )..add(
                LoadSearch(),
              ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          title: 'TKECOMMERCE',
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
