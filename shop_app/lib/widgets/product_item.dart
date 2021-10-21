import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.showOnlyFavorites})
      : super(key: key);

  final bool showOnlyFavorites;
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    Widget buildItem() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        // clipBehavior: Clip.hardEdge,
        child: GridTile(
          child: GestureDetector(
            // onDoubleTap: () => product.toggleFavoriteStatus(),
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                product.toggleFavoriteStatus();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(''),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () => product.toggleFavoriteStatus()),
                ));
              },
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Added item to the cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () => cart.removeSingleItem(product.id)),
                ));
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      );
    }

    return Consumer<Product>(builder: (ctx, product, _) {
      if (!showOnlyFavorites || (showOnlyFavorites && product.isFavorite)) {
        return buildItem();
      } else {
        return Container();
      }
    });
  }
}
