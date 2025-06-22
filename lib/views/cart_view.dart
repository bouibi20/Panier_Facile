import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/cart_controller.dart';
import '../widgets/cart_item_tile.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final currencyFormat = NumberFormat.currency(locale: 'fr_FR', symbol: '€');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Panier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              if (cartController.items.isNotEmpty) {
                Get.defaultDialog(
                  title: 'Vider le panier',
                  middleText: 'Êtes-vous sûr de vouloir vider votre panier ?',
                  textConfirm: 'Oui',
                  textCancel: 'Non',
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    cartController.clearCart();
                    Navigator.pop(context);
                  },
                );
              }
            },
            tooltip: 'Vider le panier',
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Votre panier est vide',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/'),
                  child: const Text('Continuer mes achats'),
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              // Liste des articles du panier
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartController.items[index];
                    return CartItemTile(cartItem: cartItem);
                  },
                ),
              ),

              // Résumé du panier
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currencyFormat.format(cartController.total.value),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/checkout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Passer la commande',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Get.toNamed('/'),
                      child: const Text('Continuer mes achats'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
