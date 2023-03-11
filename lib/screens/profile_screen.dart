import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/blocs/profile/profile_bloc.dart';

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
      bottomNavigationBar: const CustomNavBar(screen: ProfileScreen.routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: _profileActions(context, state),
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
                const Divider(
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

  Widget _profileActions(BuildContext context, ProfileLoaded state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Customer Information",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "Email",
            initialValue: state.user.email,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(email: value)));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "Full Name",
            initialValue: state.user.fullName,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(fullName: value)));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "Address",
            initialValue: state.user.address,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(address: value)));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "City",
            initialValue: state.user.city,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(city: value)));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "Country",
            initialValue: state.user.country,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(country: value)));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            label: "Zip Code",
            initialValue: state.user.zipCode,
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UpdateProfile(state.user.copyWith(zipCode: value)));
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthRepository>().signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(),
              fixedSize: const Size(200, 40),
            ),
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
