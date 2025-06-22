import 'package:get/get.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  
  // Variables observables
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  
  // Variables pour les filtres
  final RxSet<String> selectedCategories = <String>{}.obs;
  final RxSet<String> selectedBrands = <String>{}.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = double.infinity.obs;
  final RxBool filtersApplied = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  
  // Récupérer tous les produits
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final fetchedProducts = await _productService.getProducts();
      products.value = fetchedProducts;
      filteredProducts.value = fetchedProducts;
      
    } catch (e) {
      error.value = 'Erreur lors du chargement des produits: ${e.toString()}';
      Get.snackbar(
        'Erreur',
        'Impossible de charger les produits',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Rechercher des produits
  void searchProducts(String query) {
    searchQuery.value = query;
    applyAllFilters();
  }
  
  // Ajouter ou supprimer une catégorie des filtres
  void toggleCategoryFilter(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    applyAllFilters();
  }
  
  // Ajouter ou supprimer une marque des filtres
  void toggleBrandFilter(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
    applyAllFilters();
  }
  
  // Définir le prix minimum
  void setMinPrice(double price) {
    minPrice.value = price;
    applyAllFilters();
  }
  
  // Définir le prix maximum
  void setMaxPrice(double price) {
    maxPrice.value = price;
    applyAllFilters();
  }
  
  // Réinitialiser tous les filtres
  void resetFilters() {
    selectedCategories.clear();
    selectedBrands.clear();
    minPrice.value = 0.0;
    maxPrice.value = double.infinity;
    searchQuery.value = '';
    filtersApplied.value = false;
    filteredProducts.value = products;
  }
  
  // Appliquer tous les filtres (recherche, catégorie, marque, prix)
  void applyAllFilters() {
    List<Product> result = List<Product>.from(products);
    
    // Appliquer le filtre de recherche
    if (searchQuery.value.isNotEmpty) {
      final lowercaseQuery = searchQuery.value.toLowerCase();
      result = result.where((product) {
        return product.title.toLowerCase().contains(lowercaseQuery) ||
               product.description.toLowerCase().contains(lowercaseQuery) ||
               product.category.toLowerCase().contains(lowercaseQuery) ||
               product.brand.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }
    
    // Appliquer le filtre de catégorie
    if (selectedCategories.isNotEmpty) {
      result = result.where((product) => 
        selectedCategories.contains(product.category)
      ).toList();
    }
    
    // Appliquer le filtre de marque
    if (selectedBrands.isNotEmpty) {
      result = result.where((product) => 
        selectedBrands.contains(product.brand)
      ).toList();
    }
    
    // Appliquer le filtre de prix
    result = result.where((product) => 
      product.price >= minPrice.value && product.price <= maxPrice.value
    ).toList();
    
    // Vérifier si des filtres sont appliqués
    filtersApplied.value = selectedCategories.isNotEmpty || 
                          selectedBrands.isNotEmpty || 
                          minPrice.value > 0 || 
                          maxPrice.value < double.infinity ||
                          searchQuery.value.isNotEmpty;
    
    filteredProducts.value = result;
  }
  
  // Récupérer un produit par son ID
  Future<Product?> getProductById(int id) async {
    try {
      return await _productService.getProductById(id);
    } catch (e) {
      error.value = 'Erreur lors de la récupération du produit: ${e.toString()}';
      Get.snackbar(
        'Erreur',
        'Impossible de récupérer le produit',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
