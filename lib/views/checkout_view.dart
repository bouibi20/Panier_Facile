import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/cart_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  bool _isProcessing = false;
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final currencyFormat = NumberFormat.currency(locale: 'fr_FR', symbol: '€');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement'),
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
                  onPressed: () => Get.offAllNamed('/'),
                  child: const Text('Retourner à la boutique'),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Résumé de la commande
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Résumé de la commande',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Nombre d\'articles:'),
                                Text('${cartController.items.length}'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total:'),
                                Text(
                                  currencyFormat.format(cartController.total.value),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    const Text(
                      'Informations personnelles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nom complet
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom complet',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Adresse
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Adresse',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre adresse';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Ville et code postal
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              labelText: 'Ville',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.location_city),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre ville';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _zipCodeController,
                            decoration: const InputDecoration(
                              labelText: 'Code postal',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.markunread_mailbox),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Code postal requis';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    const Text(
                      'Informations de paiement',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Numéro de carte
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Numéro de carte',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre numéro de carte';
                        }
                        if (value.length < 16) {
                          return 'Numéro de carte invalide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Date d'expiration et CVV
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryDateController,
                            decoration: const InputDecoration(
                              labelText: 'Date d\'expiration (MM/AA)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.date_range),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date requise';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.security),
                            ),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CVV requis';
                              }
                              if (value.length < 3) {
                                return 'CVV invalide';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Bouton de paiement
                    ElevatedButton(
                      onPressed: _isProcessing
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });
                                
                                // Simulation du traitement de paiement
                                await Future.delayed(const Duration(seconds: 2));
                                
                                final success = await cartController.checkout();
                                
                                setState(() {
                                  _isProcessing = false;
                                });
                                
                                if (success) {
                                  Get.offAllNamed('/');
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Commande validée'),
                                      content: const Text(
                                        'Votre commande a été validée avec succès. Merci pour votre achat !',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Payer ${currencyFormat.format(cartController.total.value)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                    
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Retour au panier'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
