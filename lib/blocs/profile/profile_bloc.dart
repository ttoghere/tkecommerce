// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tkecommerce/app_shelf.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository? _userRepository;
  StreamSubscription? _authSubscription;
  ProfileBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(onLoadProfile);
    on<UpdateProfile>(onUpdateProfile);
    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(state.authUser));
      }
    });
  }

  void onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    if (event.authUser != null) {
      _userRepository!.getUser(userId: event.authUser!.uid).listen((user) {
        add(UpdateProfile(user));
      });
    } else {
      emit(ProfileUnauthenticated());
    }
  }

  void onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    _userRepository!.updateUser(user: event.user);
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
