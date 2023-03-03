import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/blocs_shelf.dart';
import 'package:tkecommerce/models/models.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "\$${product.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(AddProduct(product));
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                  Text("$quantity"),
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(RemoveProduct(product));
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
