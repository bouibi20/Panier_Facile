import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../controllers/cart_controller.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final Function()? onTap;

  const ProductTile({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final currencyFormat = NumberFormat.currency(locale: 'fr_FR', symbol: '€');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.indigo.withOpacity(0.05),
          highlightColor: Colors.transparent,
          child: SizedBox(
            height: 230, // Hauteur fixe pour éviter l'overflow
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image du produit avec bouton favoris
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        // Image principale
                        Center(
                          child: Hero(
                            tag: 'product-${product.id}',
                            child: Container(
                              height: 110,
                              width: double.infinity,
                              padding: const EdgeInsets.all(6),
                              child: CachedNetworkImage(
                                imageUrl: product.thumbnail,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey[300],
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Bouton favoris
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 16,
                            ),
                            onPressed: () {},
                            constraints: const BoxConstraints(
                              minWidth: 30,
                              minHeight: 30,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Informations du produit
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nom du produit
                          Text(
                            '${product.brand} ${product.title}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 2),

                          // Catégorie du produit
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const Spacer(),

                          // Prix et bouton d'ajout
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Prix
                              Text(
                                currencyFormat.format(product.price),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF333333),
                                ),
                              ),

                              // Bouton d'ajout au panier
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    cartController.addToCart(product);
                                    Get.snackbar(
                                      'Produit ajouté',
                                      '${product.title} a été ajouté au panier',
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(16),
                                      duration: const Duration(seconds: 2),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
