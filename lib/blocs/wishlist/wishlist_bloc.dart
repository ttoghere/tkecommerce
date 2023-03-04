import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_mapStartWishlistToState);
    on<AddWishlistProduct>(_mapAddWishlistProductToState);
    on<RemoveWishlistProduct>(_mapRemoveWishlistProductToState);
  }

  //This function remove items from wishlist list
  void _mapRemoveWishlistProductToState(
      RemoveWishlistProduct event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((state as WishlistLoaded).wishlist.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  //This function adds items to wishlist list
  void _mapAddWishlistProductToState(
      AddWishlistProduct event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((state as WishlistLoaded).wishlist.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  //This function inits the wishlist state to loaded from default
  //if else an error happens then the state will become error from default
  void _mapStartWishlistToState(
      StartWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (_) {
      emit(WishlistError());
    }
  }
}
