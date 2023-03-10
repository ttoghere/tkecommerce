import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tkecommerce/app_shelf.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AuthBloc _authBloc;
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _authSubscription;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required AuthBloc authBloc,
    required PaymentBloc paymentBloc,
    required CartBloc cartBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        _paymentBloc = paymentBloc,
        _checkoutRepository = checkoutRepository,
        _authBloc = authBloc,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  user: authBloc.state.user,
                  products: (cartBloc.state as CartLoaded).cart.products,
                  deliveryFee:
                      (cartBloc.state as CartLoaded).cart.deliveryFeeString,
                  subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
                  total: (cartBloc.state as CartLoaded).cart.totalString,
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _authSubscription = authBloc.stream.listen((state) {
      if (state.status == AuthStatus.unauthenticated) {
        add(const UpdateCheckout(user: User.empty));
      } else {
        add(UpdateCheckout(user: state.user));
      }
    });

    _cartSubscription = cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded)
          // ignore: curly_braces_in_flow_control_structures
          add(
            UpdateCheckout(cart: state.cart),
          );
      },
    );
    _paymentSubscription = _paymentBloc.stream.listen((state) {
      if (state.paymentStatus == PaymentStatus.initial) {
        add(UpdateCheckout(
          paymentMethod: state.paymentMethod,
          paymentMethodId: state.paymentMethodId,
        ));
      }
    });
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          user: event.user ?? state.user,
          products: event.cart?.products ?? state.products,
          deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
          subtotal: event.cart?.subtotalString ?? state.subtotal,
          total: event.cart?.totalString ?? state.total,
          paymentMethod: event.paymentMethod ?? state.paymentMethod,
          paymentMethodId:event.paymentMethodId ?? state.paymentMethodId,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        log('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
