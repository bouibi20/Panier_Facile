import 'package:get/get.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  // Variables observables
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxDouble total = 0.0.obs;
  
  // Ajouter un produit au panier
  void addToCart(Product product) {
    final existingItem = items.firstWhereOrNull(
      (item) => item.product.id == product.id
    );
    
    if (existingItem != null) {
      // Si le produit existe déjà dans le panier, augmenter la quantité
      existingItem.quantity++;
      items.refresh(); // Rafraîchir la liste pour mettre à jour l'UI
      Get.snackbar(
        'Produit ajouté',
        '${product.title} a été ajouté au panier (${existingItem.quantity})',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Sinon, ajouter un nouvel élément au panier
      items.add(CartItem(product: product));
      Get.snackbar(
        'Produit ajouté',
        '${product.title} a été ajouté au panier',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    
    // Recalculer le total
    _calculateTotal();
  }
  
  // Retirer un produit du panier
  void removeFromCart(int productId) {
    items.removeWhere((item) => item.product.id == productId);
    _calculateTotal();
    Get.snackbar(
      'Produit retiré',
      'Le produit a été retiré du panier',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Augmenter la quantité d'un produit
  void incrementQuantity(int productId) {
    final item = items.firstWhere((item) => item.product.id == productId);
    item.quantity++;
    items.refresh();
    _calculateTotal();
  }
  
  // Diminuer la quantité d'un produit
  void decrementQuantity(int productId) {
    final item = items.firstWhere((item) => item.product.id == productId);
    if (item.quantity > 1) {
      item.quantity--;
      items.refresh();
      _calculateTotal();
    } else {
      // Si la quantité est 1, retirer le produit du panier
      removeFromCart(productId);
    }
  }
  
  // Vider le panier
  void clearCart() {
    items.clear();
    _calculateTotal();
    Get.snackbar(
      'Panier vidé',
      'Votre panier a été vidé',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Calculer le total du panier
  void _calculateTotal() {
    total.value = items.fold(0, (sum, item) => sum + item.total);
  }
  
  // Finaliser la commande
  Future<bool> checkout() async {
    // Simulation d'une commande réussie
    try {
      // Ici, on pourrait ajouter un appel API pour enregistrer la commande
      await Future.delayed(const Duration(seconds: 2)); // Simulation de traitement
      
      // Vider le panier après la commande
      clearCart();
      
      Get.snackbar(
        'Commande validée',
        'Votre commande a été validée avec succès',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de la validation de votre commande',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
