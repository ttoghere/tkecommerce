import 'package:hive/hive.dart';
import 'package:tkecommerce/app_shelf.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductToWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}
