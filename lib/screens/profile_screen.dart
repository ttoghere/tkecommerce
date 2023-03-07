import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/blocs/auth/auth_bloc.dart';
import 'package:tkecommerce/blocs/profile/profile_bloc.dart';
import 'package:tkecommerce/repositories/auth/auth_repository.dart';
import 'package:tkecommerce/repositories/user/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  const ProfileScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(
          authBloc: context.read<AuthBloc>(),
          userRepository: context.read<UserRepository>(),
        )..add(
            LoadProfile(
              context.read<AuthBloc>().state.authUser,
            ),
          ),
        child: const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthRepository>().signOut();
                },
                child: const Text("Sign Out"),
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "You are not logged in",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.red,
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),
                ),
                Divider(
                  endIndent: 90,
                  indent: 90,
                  color: Colors.white,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),
                ),
              ],
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
