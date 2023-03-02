import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:tkecommerce/config/app_router.dart';
import 'package:tkecommerce/firebase_options.dart';
import 'package:tkecommerce/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
