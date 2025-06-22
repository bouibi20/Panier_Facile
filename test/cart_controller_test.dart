import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:panier_facil/controllers/cart_controller.dart';
import 'package:panier_facil/models/product.dart';

void main() {
  group('CartController Tests', () {
    late CartController cartController;

    setUp(() {
      // Initialiser le contrôleur avant chaque test
      cartController = CartController();
    });

    test('Le panier devrait être vide au départ', () {
      // Vérifier que le panier est vide initialement
      expect(cartController.items.length, 0);
      expect(cartController.total.value, 0.0);
    });

    test(
        'Ajouter un produit au panier devrait augmenter le nombre d\'articles et le total',
        () {
      // Créer un produit de test
      final product = Product(
        id: 1,
        title: 'Produit Test',
        description: 'Description du produit test',
        price: 99.99,
        discountPercentage: 10.0,
        rating: 4.5,
        stock: 50,
        brand: 'Marque Test',
        category: 'Catégorie Test',
        thumbnail: 'https://example.com/thumbnail.jpg',
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg'
        ],
      );

      // Ajouter le produit au panier
      cartController.addToCart(product);

      // Vérifier que le produit a été ajouté
      expect(cartController.items.length, 1);
      expect(cartController.items[0].product.id, product.id);
      expect(cartController.items[0].quantity, 1);
      expect(cartController.total.value, product.price);
    });

    test(
        'Ajouter le même produit plusieurs fois devrait augmenter la quantité et non le nombre d\'articles',
        () {
      // Créer un produit de test
      final product = Product(
        id: 1,
        title: 'Produit Test',
        description: 'Description du produit test',
        price: 99.99,
        discountPercentage: 10.0,
        rating: 4.5,
        stock: 50,
        brand: 'Marque Test',
        category: 'Catégorie Test',
        thumbnail: 'https://example.com/thumbnail.jpg',
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg'
        ],
      );

      // Ajouter le produit au panier deux fois
      cartController.addToCart(product);
      cartController.addToCart(product);

      // Vérifier que la quantité a augmenté mais pas le nombre d'articles
      expect(cartController.items.length, 1);
      expect(cartController.items[0].quantity, 2);
      expect(cartController.total.value, product.price * 2);
    });

    test(
        'Retirer un produit du panier devrait diminuer le nombre d\'articles et le total',
        () {
      // Créer un produit de test
      final product = Product(
        id: 1,
        title: 'Produit Test',
        description: 'Description du produit test',
        price: 99.99,
        discountPercentage: 10.0,
        rating: 4.5,
        stock: 50,
        brand: 'Marque Test',
        category: 'Catégorie Test',
        thumbnail: 'https://example.com/thumbnail.jpg',
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg'
        ],
      );

      // Ajouter le produit au panier
      cartController.addToCart(product);

      // Vérifier que le produit a été ajouté
      expect(cartController.items.length, 1);

      // Retirer le produit du panier
      cartController.removeFromCart(product.id);

      // Vérifier que le panier est vide
      expect(cartController.items.length, 0);
      expect(cartController.total.value, 0.0);
    });

    test('Vider le panier devrait réinitialiser le panier', () {
      // Créer des produits de test
      final product1 = Product(
        id: 1,
        title: 'Produit Test 1',
        description: 'Description du produit test 1',
        price: 99.99,
        discountPercentage: 10.0,
        rating: 4.5,
        stock: 50,
        brand: 'Marque Test',
        category: 'Catégorie Test',
        thumbnail: 'https://example.com/thumbnail1.jpg',
        images: ['https://example.com/image1.jpg'],
      );

      final product2 = Product(
        id: 2,
        title: 'Produit Test 2',
        description: 'Description du produit test 2',
        price: 149.99,
        discountPercentage: 5.0,
        rating: 4.0,
        stock: 30,
        brand: 'Marque Test',
        category: 'Catégorie Test',
        thumbnail: 'https://example.com/thumbnail2.jpg',
        images: ['https://example.com/image2.jpg'],
      );

      // Ajouter les produits au panier
      cartController.addToCart(product1);
      cartController.addToCart(product2);

      // Vérifier que les produits ont été ajoutés
      expect(cartController.items.length, 2);
      expect(cartController.total.value, product1.price + product2.price);

      // Vider le panier
      cartController.clearCart();

      // Vérifier que le panier est vide
      expect(cartController.items.length, 0);
      expect(cartController.total.value, 0.0);
    });
  });
}
