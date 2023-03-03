import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/cart/cart_bloc.dart';
import 'package:tkecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:tkecommerce/config/app_router.dart';
import 'package:tkecommerce/firebase_options.dart';
import 'package:tkecommerce/observer/bloc_observer.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
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
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'TKECOMMERCE',
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
