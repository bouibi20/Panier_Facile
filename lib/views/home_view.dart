import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Méthode pour construire la bottom sheet de filtrage
  Widget buildFilterBottomSheet(
      BuildContext context, ProductController controller) {
    // Liste des catégories disponibles
    final categories =
        controller.products.map((product) => product.category).toSet().toList();

    // Liste des marques disponibles
    final brands =
        controller.products.map((product) => product.brand).toSet().toList();

    // Contrôleurs pour les champs de texte de prix
    final minPriceController = TextEditingController(
        text: controller.minPrice.value > 0
            ? controller.minPrice.value.toString()
            : '');
    final maxPriceController = TextEditingController(
        text: controller.maxPrice.value < double.infinity
            ? controller.maxPrice.value.toString()
            : '');

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          // En-tête
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Filtres',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Obx(() => controller.filtersApplied.value
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Actifs',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      : const SizedBox()),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),

          // Section Prix
          const Text(
            'Prix',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Min',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        try {
                          controller.setMinPrice(double.parse(value));
                        } catch (e) {
                          // Ignorer si la valeur n'est pas un nombre
                        }
                      } else {
                        controller.setMinPrice(0);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Max',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        try {
                          controller.setMaxPrice(double.parse(value));
                        } catch (e) {
                          // Ignorer si la valeur n'est pas un nombre
                        }
                      } else {
                        controller.setMaxPrice(double.infinity);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Section Catégories
          const Text(
            'Catégories',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories
                    .map((category) => FilterChip(
                          label: Text(category),
                          selected:
                              controller.selectedCategories.contains(category),
                          onSelected: (selected) {
                            controller.toggleCategoryFilter(category);
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor:
                              const Color(0xFF6C63FF).withOpacity(0.2),
                          checkmarkColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ))
                    .toList(),
              )),

          const SizedBox(height: 20),

          // Section Marques
          const Text(
            'Marques',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: brands
                    .map((brand) => FilterChip(
                          label: Text(brand),
                          selected: controller.selectedBrands.contains(brand),
                          onSelected: (selected) {
                            controller.toggleBrandFilter(brand);
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor:
                              const Color(0xFF6C63FF).withOpacity(0.2),
                          checkmarkColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ))
                    .toList(),
              )),

          const SizedBox(height: 20),

          // Boutons d'action
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Réinitialiser les filtres
                    controller.resetFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6C63FF)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Réinitialiser'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Appliquer les filtres
                    controller.applyAllFilters();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Appliquer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Méthode pour construire une section d'informations
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }

  // Méthode pour construire une ligne d'information
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier Facil'),
        actions: [
          Obx(() => Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed('/cart'),
                  ),
                  if (cartController.items.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartController.items.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              )),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche et filtres
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: Colors.grey[50],
            child: Row(
              children: [
                // Champ de recherche avec design moderne
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) =>
                          productController.searchProducts(value),
                      decoration: InputDecoration(
                        hintText: 'Rechercher un produit...',
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 15),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey[500], size: 22),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: Obx(
                          () => productController.searchQuery.value.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear,
                                      color: Colors.grey[400], size: 18),
                                  onPressed: () {
                                    // Vider le champ de texte
                                    searchController.clear();
                                    productController.searchProducts('');
                                    FocusScope.of(context).unfocus();
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bouton de filtres
                Obx(() => Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6C63FF).withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Afficher les options de filtrage
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) => buildFilterBottomSheet(
                                      context, productController),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        // Badge indicateur de filtres actifs
                        if (productController.filtersApplied.value)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  '!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )),
              ],
            ),
          ),

          // Liste des produits
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (productController.error.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Erreur: ${productController.error.value}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: productController.fetchProducts,
                        child: const Text('Réessayer'),
                      ),
                    ],
                  ),
                );
              } else if (productController.filteredProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'Aucun produit trouvé',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: productController.fetchProducts,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 colonnes
                    ),
                    itemCount: productController.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = productController.filteredProducts[index];
                      return ProductTile(
                        product: product,
                        onTap: () {
                          // Afficher les détails du produit dans une boîte de dialogue
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // En-tête avec image et SKU
                                      Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                product.thumbnail,
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (product.sku.isNotEmpty)
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'SKU: ${product.sku}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      // Titre et prix
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.title,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${product.price.toStringAsFixed(2)} €',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              if (product.discountPercentage >
                                                  0)
                                                Text(
                                                  '-${product.discountPercentage.toStringAsFixed(1)}%',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[700],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      // Description
                                      Text(
                                        product.description,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800]),
                                      ),
                                      const SizedBox(height: 16),

                                      // Informations principales
                                      _buildInfoSection(
                                          'Informations principales', [
                                        _buildInfoRow(Icons.business, 'Marque',
                                            product.brand),
                                        _buildInfoRow(Icons.category,
                                            'Catégorie', product.category),
                                        _buildInfoRow(Icons.star, 'Note',
                                            '${product.rating.toStringAsFixed(1)}/5'),
                                        _buildInfoRow(Icons.inventory_2,
                                            'Stock', '${product.stock} unités'),
                                        if (product
                                            .availabilityStatus.isNotEmpty)
                                          _buildInfoRow(
                                              Icons.check_circle,
                                              'Disponibilité',
                                              product.availabilityStatus),
                                      ]),

                                      // Spécifications
                                      if (product.weight > 0 ||
                                          (product.dimensions.width > 0 &&
                                              product.dimensions.height > 0 &&
                                              product.dimensions.depth > 0))
                                        _buildInfoSection('Spécifications', [
                                          if (product.weight > 0)
                                            _buildInfoRow(Icons.scale, 'Poids',
                                                '${product.weight} g'),
                                          if (product.dimensions.width > 0 &&
                                              product.dimensions.height > 0 &&
                                              product.dimensions.depth > 0)
                                            _buildInfoRow(
                                                Icons.straighten,
                                                'Dimensions',
                                                '${product.dimensions.width.toStringAsFixed(1)} × ${product.dimensions.height.toStringAsFixed(1)} × ${product.dimensions.depth.toStringAsFixed(1)} cm'),
                                          if (product.minimumOrderQuantity > 1)
                                            _buildInfoRow(
                                                Icons.shopping_bag,
                                                'Quantité minimum',
                                                '${product.minimumOrderQuantity}'),
                                        ]),

                                      // Expédition et garantie
                                      if (product.shippingInformation.isNotEmpty ||
                                          product
                                              .warrantyInformation.isNotEmpty ||
                                          product.returnPolicy.isNotEmpty)
                                        _buildInfoSection(
                                            'Expédition et garantie', [
                                          if (product
                                              .shippingInformation.isNotEmpty)
                                            _buildInfoRow(
                                                Icons.local_shipping,
                                                'Expédition',
                                                product.shippingInformation),
                                          if (product
                                              .warrantyInformation.isNotEmpty)
                                            _buildInfoRow(
                                                Icons.verified,
                                                'Garantie',
                                                product.warrantyInformation),
                                          if (product.returnPolicy.isNotEmpty)
                                            _buildInfoRow(
                                                Icons.assignment_return,
                                                'Retours',
                                                product.returnPolicy),
                                        ]),

                                      // Tags
                                      if (product.tags.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text(
                                                'Tags',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Wrap(
                                              spacing: 6,
                                              runSpacing: 6,
                                              children: product.tags
                                                  .map((tag) => Chip(
                                                        label: Text(tag),
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .blue[800]),
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ))
                                                  .toList(),
                                            ),
                                          ],
                                        ),

                                      // Avis clients
                                      if (product.reviews.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text(
                                                'Avis clients',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ...product.reviews
                                                .map((review) => Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                review
                                                                    .reviewerName,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: List
                                                                    .generate(
                                                                  5,
                                                                  (index) =>
                                                                      Icon(
                                                                    index < review.rating
                                                                        ? Icons
                                                                            .star
                                                                        : Icons
                                                                            .star_border,
                                                                    color: Colors
                                                                        .amber,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(review.comment),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                          ],
                                        ),

                                      const SizedBox(height: 24),
                                      // Boutons d'action
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () => Get.back(),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            child: const Text('Fermer'),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              cartController.addToCart(product);
                                              Get.back();
                                              Get.snackbar(
                                                'Produit ajouté',
                                                '${product.title} a été ajouté à votre panier',
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor: Colors.green,
                                                colorText: Colors.white,
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                            },
                                            icon:
                                                const Icon(Icons.shopping_cart),
                                            label:
                                                const Text('Ajouter au panier'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
