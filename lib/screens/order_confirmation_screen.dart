// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tkecommerce/models/product_model.dart';
import 'package:tkecommerce/widgets/widgets_shelf.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = "/orderconfirmation";
  const OrderConfirmationScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      appBar: AppBar(
        title: Text(
          "Order Confirmation",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  top: 10,
                  left: (MediaQuery.of(context).size.width - 120) / 2,
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 130,
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 160,
                  child: Text(
                    "Your Order Is Complete",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Code: #123-a12a",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thank you for purchasing on TKEcommerce",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Order Code: #123-a12a",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const OrderSummary(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Order Details",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              padding: const EdgeInsets.only(left: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Product.products.length,
              itemBuilder: (context, index) {
                return OrderSummaryProductCard(
                  quantity: index,
                  product: Product.products[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryProductCard extends StatelessWidget {
  final Product product;
  final int quantity;

  const OrderSummaryProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            height: 80,
            width: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Qty. $quantity",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              "\$${product.price}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
