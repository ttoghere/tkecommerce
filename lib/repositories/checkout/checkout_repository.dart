// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tkecommerce/models/models.dart';
import 'package:tkecommerce/repositories/checkout/base_checkout_repository.dart';



class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection("checkout").add(checkout.toDocument());
  }
}
