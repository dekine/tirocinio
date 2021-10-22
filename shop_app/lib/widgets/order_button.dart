import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show Cart;
import '../providers/orders_provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              TextStyle(color: Theme.of(context).colorScheme.primary))),
    );
  }
}
