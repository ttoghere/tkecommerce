import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tkecommerce/app_shelf.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;
  WishlistBloc({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishlist>(_mapStartWishlistToState);
    on<AddWishlistProduct>(_mapAddWishlistProductToState);
    on<RemoveWishlistProduct>(_mapRemoveWishlistProductToState);
  }

  //This function remove items from wishlist list
  void _mapRemoveWishlistProductToState(
      RemoveWishlistProduct event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductToWishlist(box, event.product);
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
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);
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
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded(wishlist: Wishlist(products: products)));
    } catch (_) {
      emit(WishlistError());
    }
  }
}
