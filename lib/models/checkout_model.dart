import 'package:equatable/equatable.dart';
import 'package:tkecommerce/app_shelf.dart';

class Checkout extends Equatable {
  final String? fullName;
  final String? email;
  final String? city;
  final String? address;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  const Checkout({
    this.fullName,
    this.email,
    this.city,
    this.address,
    this.country,
    this.zipCode,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        city,
        address,
        country,
        zipCode,
        products,
        subtotal,
        deliveryFee,
        total,
      ];

  Map<String, Object> toDocument() {
    Map<String, Object> customerAddress = {};
    customerAddress["address"] = address!;
    customerAddress["city"] = city!;
    customerAddress["country"] = country!;
    customerAddress["zipCode"] = zipCode!;

    return {
      "customerAddress": customerAddress,
      "customerName": fullName!,
      "customerEmail": email!,
      "products": products!.map((e) => e.name).toList(),
      "subtotal": subtotal!,
      "deliveryFee": deliveryFee!,
      "total": total!,
    };
  }
}
