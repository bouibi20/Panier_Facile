import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    // Initialisation des contrôleurs en mode lazyPut
    // Ils seront instanciés uniquement lorsqu'ils seront utilisés
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}
