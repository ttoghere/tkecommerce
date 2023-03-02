part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

//Default event blueprint for wishlist
class StartWishlist extends WishlistEvent {}

//Add Item event blueprint for wishlist
class AddWishlistProduct extends WishlistEvent {
  final Product product;
  const AddWishlistProduct(this.product);
  @override
  List<Object> get props => [product];
}

//Remove Item event blueprint for wishlist
class RemoveWishlistProduct extends WishlistEvent {
  final Product product;
  const RemoveWishlistProduct(this.product);
  @override
  List<Object> get props => [product];
}
