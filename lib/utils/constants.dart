class AppConstants {
  // API
  static const String baseUrl = 'https://dummyjson.com';
  static const String productsEndpoint = '/products';
  
  // Routes
  static const String homeRoute = '/';
  static const String cartRoute = '/cart';
  static const String checkoutRoute = '/checkout';
  
  // App
  static const String appName = 'Panier Facil';
  
  // Messages
  static const String errorLoadingProducts = 'Erreur lors du chargement des produits';
  static const String noProductsFound = 'Aucun produit trouvé';
  static const String cartEmpty = 'Votre panier est vide';
  static const String orderConfirmed = 'Commande confirmée';
  static const String orderConfirmedMessage = 'Votre commande a été validée avec succès';
}
