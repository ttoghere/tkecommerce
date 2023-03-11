// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tkecommerce/app_shelf.dart';

class SearchBox extends StatelessWidget {
  final Category? category;
  const SearchBox({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchLoaded) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search for a product",
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          context.read<SearchBloc>().add(SearchProduct(
                                productName: value,
                                category: category,
                              ));
                        },
                      ),
                    ),
                  ],
                ),
                state.products.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ProductCard.catalog(
                            product: state.products[index],
                            widthFactor: 1.1,
                          ),
                        ),
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        } else {
          return const Center(child: Text("Something Went Wrong"));
        }
      },
    );
  }
}
