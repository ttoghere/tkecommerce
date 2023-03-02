// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tkecommerce/models/models.dart';

//Blueprint for Wishlist Items
class Wishlist extends Equatable {
  final List<Product> products;
  const Wishlist({this.products = const []});

  @override
  List<Object> get props => [products];
}
