import 'package:equatable/equatable.dart';
import 'package:tkecommerce/app_shelf.dart';

class Checkout extends Equatable {
  final User? user;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  const Checkout({
    this.user,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
  });

  @override
  List<Object?> get props => [
        user,
        products,
        subtotal,
        deliveryFee,
        total,
      ];

  Map<String, Object> toDocument() {
    return {
      "user": user?.toDocument() ?? User.empty.toDocument(),
      "products": products!.map((e) => e.name).toList(),
      "subtotal": subtotal!,
      "deliveryFee": deliveryFee!,
      "total": total!,
    };
  }
}
