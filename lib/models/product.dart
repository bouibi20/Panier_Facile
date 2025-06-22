class ProductDimensions {
  final double width;
  final double height;
  final double depth;

  const ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      width: json['width'] == null ? 0.0 : 
             (json['width'] is int) ? json['width'].toDouble() : 
             (json['width'] is String) ? double.tryParse(json['width']) ?? 0.0 : 
             (json['width'] is double) ? json['width'] : 0.0,
      height: json['height'] == null ? 0.0 : 
              (json['height'] is int) ? json['height'].toDouble() : 
              (json['height'] is String) ? double.tryParse(json['height']) ?? 0.0 : 
              (json['height'] is double) ? json['height'] : 0.0,
      depth: json['depth'] == null ? 0.0 : 
             (json['depth'] is int) ? json['depth'].toDouble() : 
             (json['depth'] is String) ? double.tryParse(json['depth']) ?? 0.0 : 
             (json['depth'] is double) ? json['depth'] : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}

class ProductReview {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  const ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: json['rating'] ?? 0,
      comment: json['comment']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      reviewerName: json['reviewerName']?.toString() ?? '',
      reviewerEmail: json['reviewerEmail']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class ProductMeta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  const ProductMeta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory ProductMeta.fromJson(Map<String, dynamic> json) {
    return ProductMeta(
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      barcode: json['barcode']?.toString() ?? '',
      qrCode: json['qrCode']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final List<String> tags;
  final String sku;
  final int weight;
  final ProductDimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ProductReview> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final ProductMeta meta;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.tags = const [],
    this.sku = '',
    this.weight = 0,
    this.dimensions = const ProductDimensions(width: 0, height: 0, depth: 0),
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.availabilityStatus = '',
    this.reviews = const [],
    this.returnPolicy = '',
    this.minimumOrderQuantity = 1,
    this.meta = const ProductMeta(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] == null ? 0.0 : 
             (json['price'] is int) ? json['price'].toDouble() : 
             (json['price'] is String) ? double.tryParse(json['price']) ?? 0.0 : json['price'],
      discountPercentage: json['discountPercentage'] == null ? 0.0 : 
                         (json['discountPercentage'] is int) ? json['discountPercentage'].toDouble() : 
                         (json['discountPercentage'] is String) ? double.tryParse(json['discountPercentage']) ?? 0.0 : json['discountPercentage'],
      rating: json['rating'] == null ? 0.0 : 
              (json['rating'] is int) ? json['rating'].toDouble() : 
              (json['rating'] is String) ? double.tryParse(json['rating']) ?? 0.0 : json['rating'],
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images'].map((img) => img?.toString() ?? '')) : [],
      tags: json['tags'] != null ? List<String>.from(json['tags'].map((tag) => tag?.toString() ?? '')) : [],
      sku: json['sku']?.toString() ?? '',
      weight: json['weight'] ?? 0,
      dimensions: json['dimensions'] != null ? 
                 ProductDimensions.fromJson(json['dimensions'] is Map ? 
                                           Map<String, dynamic>.from(json['dimensions']) : 
                                           <String, dynamic>{'width': 0.0, 'height': 0.0, 'depth': 0.0}) : 
                 const ProductDimensions(width: 0, height: 0, depth: 0),
      warrantyInformation: json['warrantyInformation']?.toString() ?? '',
      shippingInformation: json['shippingInformation']?.toString() ?? '',
      availabilityStatus: json['availabilityStatus']?.toString() ?? '',
      reviews: json['reviews'] != null ? 
               (json['reviews'] as List).map((review) => 
                 ProductReview.fromJson(review is Map ? 
                                       Map<String, dynamic>.from(review) : 
                                       <String, dynamic>{'rating': 0, 'comment': '', 'date': '', 'reviewerName': '', 'reviewerEmail': ''})
               ).toList() : 
               [],
      returnPolicy: json['returnPolicy']?.toString() ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      meta: json['meta'] != null ? 
            ProductMeta.fromJson(json['meta'] is Map ? 
                               Map<String, dynamic>.from(json['meta']) : 
                               <String, dynamic>{'createdAt': '', 'updatedAt': '', 'barcode': '', 'qrCode': ''}) : 
            const ProductMeta(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
      'tags': tags,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
    };
  }
}
