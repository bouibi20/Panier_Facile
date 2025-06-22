# Panier Facil - Application Flutter E-commerce

Application e-commerce moderne développée avec Flutter et utilisant l'architecture MVC avec GetX pour la gestion d'état et la navigation.

## Description

Panier Facil est une application e-commerce complète qui permet aux utilisateurs de parcourir des produits, les filtrer, les ajouter à un panier et simuler un processus de paiement. L'application utilise l'API [DummyJSON](https://dummyjson.com/products) pour récupérer les données des produits et présente une interface utilisateur moderne et réactive.

## Spécifications techniques

### Environnement de développement

- **Flutter SDK** : Version 3.4.3 ou supérieure
- **Dart SDK** : Version 3.4.3 ou supérieure (basé sur `environment.sdk` dans pubspec.yaml)
- **IDE recommandés** : Visual Studio Code, Android Studio, IntelliJ IDEA

### Compatibilité

- **Android** : API 21+ (Android 5.0 Lollipop et versions ultérieures)
- **iOS** : iOS 11.0 et versions ultérieures
- **Web** : Navigateurs modernes (Chrome, Firefox, Safari, Edge)

## Installation

### Prérequis

- Flutter SDK (version 3.4.3 ou supérieure)
- Dart SDK (version 3.4.3 ou supérieure)
- Git
- Un éditeur de code comme VS Code ou Android Studio

### Étapes d'installation

1. Cloner le dépôt
   ```bash
   git clone https://github.com/votre-utilisateur/ma_boutique_exercice.git
   cd ma_boutique_exercice
   ```

2. Installer les dépendances
   ```bash
   flutter pub get
   ```

3. Exécuter l'application
   ```bash
   flutter run
   ```
   
4. Pour exécuter sur un navigateur web spécifique
   ```bash
   flutter run -d chrome
   ```

## Architecture et structure du projet

L'application est structurée selon le pattern MVC (Modèle-Vue-Contrôleur) avec GetX pour une gestion d'état réactive et une injection de dépendances simplifiée.

### Structure des répertoires

```
lib/
├── app/                  # Configuration de l'application
│   ├── app.dart          # Point d'entrée de l'application
│   └── router.dart       # Configuration des routes
├── bindings/             # Injection de dépendances
│   └── app_bindings.dart # Initialisation des contrôleurs
├── controllers/          # Logique métier et gestion d'état
│   ├── cart_controller.dart
│   └── product_controller.dart
├── models/               # Modèles de données
│   ├── cart_item.dart
│   └── product.dart
├── services/             # Services pour les API externes
│   └── product_service.dart
├── utils/                # Utilitaires et constantes
│   └── constants.dart
├── views/                # Écrans de l'application
│   ├── cart_view.dart
│   ├── checkout_view.dart
│   └── home_view.dart
└── widgets/              # Composants réutilisables
    ├── cart_item_tile.dart
    └── product_tile.dart
```

### Modèles (Models)

- **`product.dart`** : Modèle complet de produit avec tous les attributs nécessaires :
  - Propriétés de base (id, titre, description, prix)
  - Informations détaillées (marque, catégorie, notation, stock)
  - Métadonnées (SKU, tags, dimensions, poids)
  - Informations de livraison et garantie
  - Avis clients

- **`cart_item.dart`** : Modèle d'article de panier avec gestion des quantités et calcul des sous-totaux

### Vues (Views)

- **`home_view.dart`** : Écran principal avec :
  - Affichage des produits en liste ou grille
  - Barre de recherche réactive
  - Affichage détaillé des produits dans une boîte de dialogue

- **`cart_view.dart`** : Écran du panier avec :
  - Liste des articles sélectionnés
  - Gestion des quantités
  - Calcul du total et des frais
  - Bouton de passage à la caisse

- **`checkout_view.dart`** : Écran de paiement avec :
  - Formulaire de coordonnées
  - Options de livraison
  - Récapitulatif de commande
  - Simulation de paiement

### Contrôleurs (Controllers)

- **`product_controller.dart`** : Gestion des produits avec :
  - Récupération des produits depuis l'API
  - Recherche et filtrage
  - Gestion des états de chargement et d'erreur
  - Variables réactives (`.obs`) pour une mise à jour automatique de l'UI

- **`cart_controller.dart`** : Gestion du panier avec :
  - Ajout, suppression et modification des articles
  - Calcul du total et des frais
  - Persistance du panier entre les sessions

### Services

- **`product_service.dart`** : Service pour les appels API avec :
  - Méthodes pour récupérer les produits
  - Gestion des erreurs HTTP
  - Transformation des réponses JSON en objets Dart

### Bindings

- **`app_bindings.dart`** : Configuration de l'injection de dépendances avec GetX

### Widgets

- **`product_tile.dart`** : Widget personnalisé pour l'affichage des produits avec :
  - Gestion des images avec mise en cache
  - Affichage des informations essentielles
  - Boutons d'action (ajout au panier, favoris)
  - Animations et effets visuels

- **`cart_item_tile.dart`** : Widget pour l'affichage des articles du panier

## Fonctionnalités principales

### Interface utilisateur
- **Design moderne** : Interface utilisateur élégante et intuitive avec des animations fluides
- **Affichage en grille et liste** : Possibilité d'afficher les produits dans différents formats
- **Thème personnalisé** : Palette de couleurs cohérente avec des accents indigo/violet
- **Interface responsive** : Adaptation automatique à différentes tailles d'écran (mobile, tablette, desktop)
- **Mode sombre** : Support du mode sombre basé sur les paramètres système

### Fonctionnalités e-commerce
- **Catalogue de produits** : Affichage des produits avec images, titres, descriptions et prix
- **Filtres avancés** : Filtrage par catégorie, plage de prix et autres attributs
- **Recherche intelligente** : Recherche par nom, description, catégorie ou marque
- **Détails produit** : Vue détaillée avec spécifications complètes et avis clients
- **Gestion du panier** : Ajout, suppression et modification de la quantité des produits
- **Favoris** : Possibilité de marquer des produits comme favoris
- **Processus de paiement** : Simulation d'un processus de paiement avec formulaire et validation

### Architecture et performances
- **Gestion d'état réactive** : Utilisation des variables observables de GetX (`.obs`) pour une UI réactive
- **Navigation optimisée** : Système de navigation de GetX avec routes nommées et transitions fluides
- **Mise en cache des images** : Optimisation du chargement et de l'affichage des images
- **Gestion des erreurs** : Système robuste avec affichage de messages d'erreur via Snackbars
- **Chargement progressif** : Indicateurs de chargement et animations de transition

## Dépendances utilisées

| Package | Version | Utilisation |
|---------|---------|-------------|
| [flutter](https://flutter.dev) | SDK | Framework UI principal |
| [get](https://pub.dev/packages/get) | ^4.6.6 | Gestion d'état, navigation, injection de dépendances |
| [http](https://pub.dev/packages/http) | ^1.2.0 | Appels API RESTful |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | ^3.3.1 | Mise en cache et gestion des images réseau |
| [intl](https://pub.dev/packages/intl) | ^0.19.0 | Formatage des nombres, dates et internationalisation |
| [cupertino_icons](https://pub.dev/packages/cupertino_icons) | ^1.0.6 | Icônes de style iOS |

## Commandes utiles

### Développement
```bash
# Lancer l'application sur l'appareil connecté
flutter run

# Lancer l'application sur Chrome
flutter run -d chrome

# Lancer l'application avec le mode de performance
flutter run --profile

# Lancer les tests
flutter test
```

### Construction
```bash
# Construire l'APK pour Android
flutter build apk --split-per-abi

# Construire pour iOS
flutter build ios

# Construire pour le web
flutter build web
```

### Maintenance
```bash
# Nettoyer le projet
flutter clean

# Mettre à jour les dépendances
flutter pub upgrade

# Analyser le code
flutter analyze
```

## Tests et assurance qualité

L'application inclut plusieurs types de tests pour garantir sa qualité :

### Tests unitaires
- **`cart_controller_test.dart`** : Vérifie les fonctionnalités du panier :
  - Ajout d'articles au panier
  - Suppression d'articles
  - Modification des quantités
  - Calcul correct des totaux
  - Gestion des erreurs

### Bonnes pratiques de développement
- **Séparation des préoccupations** : Architecture MVC claire
- **Code propre** : Respect des conventions de nommage et de formatage Dart
- **Documentation** : Commentaires explicatifs sur les fonctions complexes
- **Gestion des erreurs** : Traitement approprié des exceptions
- **Optimisation des performances** : Utilisation judicieuse des widgets avec état

### Perspectives futures

### Améliorations prévues
- **Authentification** : Implémentation d'un système de connexion et d'inscription
- **Paiement réel** : Intégration de passerelles de paiement comme Stripe ou PayPal
- **Historique des commandes** : Suivi des commandes passées
- **Notifications** : Alertes pour les promotions et le statut des commandes
- **Multilinguisme** : Support de plusieurs langues avec GetX
- **Mode hors ligne** : Fonctionnement de base sans connexion Internet

### Optimisations techniques
- **Tests d'intégration** : Ajout de tests pour les flux complets
- **Tests d'interface** : Vérification de la cohérence visuelle
- **CI/CD** : Intégration continue et déploiement continu
- **Analytics** : Suivi des comportements utilisateurs
- **Performance** : Amélioration des temps de chargement et de la réactivité

## Conclusion

Panier Facil est une application e-commerce complète et moderne développée avec Flutter et GetX. Elle offre une expérience utilisateur fluide et intuitive, avec une architecture robuste et maintenable. Le projet suit les meilleures pratiques de développement Flutter et peut servir de base solide pour des applications e-commerce plus complexes.

N'hésitez pas à contribuer au projet ou à l'utiliser comme référence pour vos propres développements Flutter.

Pour exécuter les tests :

```bash
flutter test
```
