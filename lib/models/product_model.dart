import 'dart:convert';

class ProductModel {
    final List<Product> products;
    final int total;
    final int skip;
    final int limit;

    ProductModel({
        required this.products,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    final int id;
    final String title;
    final String description;
    final String category;
    final double price;
    final double discountPercentage;
    final double rating;
    final int stock;
    final List<String> tags;
    final String? brand;
    final String sku;
    final int weight;
    final Dimensions dimensions;
    final WarrantyInformation warrantyInformation;
    final ShippingInformation shippingInformation;
    final AvailabilityStatus availabilityStatus;
    final List<Review> reviews;
    final ReturnPolicy returnPolicy;
    final int minimumOrderQuantity;
    final Meta meta;
    final List<String> images;
    final String thumbnail;

    Product({
        required this.id,
        required this.title,
        required this.description,
        required this.category,
        required this.price,
        required this.discountPercentage,
        required this.rating,
        required this.stock,
        required this.tags,
        this.brand,
        required this.sku,
        required this.weight,
        required this.dimensions,
        required this.warrantyInformation,
        required this.shippingInformation,
        required this.availabilityStatus,
        required this.reviews,
        required this.returnPolicy,
        required this.minimumOrderQuantity,
        required this.meta,
        required this.images,
        required this.thumbnail,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        brand: json["brand"],
        sku: json["sku"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        warrantyInformation: warrantyInformationValues.map[json["warrantyInformation"]]!,
        shippingInformation: shippingInformationValues.map[json["shippingInformation"]]!,
        availabilityStatus: availabilityStatusValues.map[json["availabilityStatus"]]!,
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        returnPolicy: returnPolicyValues.map[json["returnPolicy"]]!,
        minimumOrderQuantity: json["minimumOrderQuantity"],
        meta: Meta.fromJson(json["meta"]),
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "warrantyInformation": warrantyInformationValues.reverse[warrantyInformation],
        "shippingInformation": shippingInformationValues.reverse[shippingInformation],
        "availabilityStatus": availabilityStatusValues.reverse[availabilityStatus],
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "returnPolicy": returnPolicyValues.reverse[returnPolicy],
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
    };
}

enum AvailabilityStatus {
    IN_STOCK,
    LOW_STOCK,
    OUT_OF_STOCK
}

final availabilityStatusValues = EnumValues({
    "In Stock": AvailabilityStatus.IN_STOCK,
    "Low Stock": AvailabilityStatus.LOW_STOCK,
    "Out of Stock": AvailabilityStatus.OUT_OF_STOCK
});

class Dimensions {
    final double width;
    final double height;
    final double depth;

    Dimensions({
        required this.width,
        required this.height,
        required this.depth,
    });

    factory Dimensions.fromRawJson(String str) => Dimensions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
    };
}

class Meta {
    final DateTime createdAt;
    final DateTime updatedAt;
    final String barcode;
    final String qrCode;

    Meta({
        required this.createdAt,
        required this.updatedAt,
        required this.barcode,
        required this.qrCode,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        barcode: json["barcode"],
        qrCode: json["qrCode"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "barcode": barcode,
        "qrCode": qrCode,
    };
}

enum ReturnPolicy {
    NO_RETURN_POLICY,
    THE_30_DAYS_RETURN_POLICY,
    THE_60_DAYS_RETURN_POLICY,
    THE_7_DAYS_RETURN_POLICY,
    THE_90_DAYS_RETURN_POLICY
}

final returnPolicyValues = EnumValues({
    "No return policy": ReturnPolicy.NO_RETURN_POLICY,
    "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
    "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
    "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
    "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY
});

class Review {
    final int rating;
    final Comment comment;
    final DateTime date;
    final String reviewerName;
    final String reviewerEmail;

    Review({
        required this.rating,
        required this.comment,
        required this.date,
        required this.reviewerName,
        required this.reviewerEmail,
    });

    factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        comment: commentValues.map[json["comment"]]!,
        date: DateTime.parse(json["date"]),
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": commentValues.reverse[comment],
        "date": date.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
    };
}

enum Comment {
    AWESOME_PRODUCT,
    DISAPPOINTING_PRODUCT,
    EXCELLENT_QUALITY,
    FAST_SHIPPING,
    GREAT_PRODUCT,
    GREAT_VALUE_FOR_MONEY,
    HIGHLY_IMPRESSED,
    HIGHLY_RECOMMENDED,
    NOT_AS_DESCRIBED,
    NOT_WORTH_THE_PRICE,
    POOR_QUALITY,
    VERY_DISAPPOINTED,
    VERY_DISSATISFIED,
    VERY_HAPPY_WITH_MY_PURCHASE,
    VERY_PLEASED,
    VERY_SATISFIED,
    VERY_UNHAPPY_WITH_MY_PURCHASE,
    WASTE_OF_MONEY,
    WOULD_BUY_AGAIN,
    WOULD_NOT_BUY_AGAIN,
    WOULD_NOT_RECOMMEND
}

final commentValues = EnumValues({
    "Awesome product!": Comment.AWESOME_PRODUCT,
    "Disappointing product!": Comment.DISAPPOINTING_PRODUCT,
    "Excellent quality!": Comment.EXCELLENT_QUALITY,
    "Fast shipping!": Comment.FAST_SHIPPING,
    "Great product!": Comment.GREAT_PRODUCT,
    "Great value for money!": Comment.GREAT_VALUE_FOR_MONEY,
    "Highly impressed!": Comment.HIGHLY_IMPRESSED,
    "Highly recommended!": Comment.HIGHLY_RECOMMENDED,
    "Not as described!": Comment.NOT_AS_DESCRIBED,
    "Not worth the price!": Comment.NOT_WORTH_THE_PRICE,
    "Poor quality!": Comment.POOR_QUALITY,
    "Very disappointed!": Comment.VERY_DISAPPOINTED,
    "Very dissatisfied!": Comment.VERY_DISSATISFIED,
    "Very happy with my purchase!": Comment.VERY_HAPPY_WITH_MY_PURCHASE,
    "Very pleased!": Comment.VERY_PLEASED,
    "Very satisfied!": Comment.VERY_SATISFIED,
    "Very unhappy with my purchase!": Comment.VERY_UNHAPPY_WITH_MY_PURCHASE,
    "Waste of money!": Comment.WASTE_OF_MONEY,
    "Would buy again!": Comment.WOULD_BUY_AGAIN,
    "Would not buy again!": Comment.WOULD_NOT_BUY_AGAIN,
    "Would not recommend!": Comment.WOULD_NOT_RECOMMEND
});

enum ShippingInformation {
    SHIPS_IN_12_BUSINESS_DAYS,
    SHIPS_IN_1_MONTH,
    SHIPS_IN_1_WEEK,
    SHIPS_IN_2_WEEKS,
    SHIPS_IN_35_BUSINESS_DAYS,
    SHIPS_OVERNIGHT
}

final shippingInformationValues = EnumValues({
    "Ships in 1-2 business days": ShippingInformation.SHIPS_IN_12_BUSINESS_DAYS,
    "Ships in 1 month": ShippingInformation.SHIPS_IN_1_MONTH,
    "Ships in 1 week": ShippingInformation.SHIPS_IN_1_WEEK,
    "Ships in 2 weeks": ShippingInformation.SHIPS_IN_2_WEEKS,
    "Ships in 3-5 business days": ShippingInformation.SHIPS_IN_35_BUSINESS_DAYS,
    "Ships overnight": ShippingInformation.SHIPS_OVERNIGHT
});

enum WarrantyInformation {
    LIFETIME_WARRANTY,
    NO_WARRANTY,
    THE_1_MONTH_WARRANTY,
    THE_1_WEEK_WARRANTY,
    THE_1_YEAR_WARRANTY,
    THE_2_YEAR_WARRANTY,
    THE_3_MONTHS_WARRANTY,
    THE_3_YEAR_WARRANTY,
    THE_5_YEAR_WARRANTY,
    THE_6_MONTHS_WARRANTY
}

final warrantyInformationValues = EnumValues({
    "Lifetime warranty": WarrantyInformation.LIFETIME_WARRANTY,
    "No warranty": WarrantyInformation.NO_WARRANTY,
    "1 month warranty": WarrantyInformation.THE_1_MONTH_WARRANTY,
    "1 week warranty": WarrantyInformation.THE_1_WEEK_WARRANTY,
    "1 year warranty": WarrantyInformation.THE_1_YEAR_WARRANTY,
    "2 year warranty": WarrantyInformation.THE_2_YEAR_WARRANTY,
    "3 months warranty": WarrantyInformation.THE_3_MONTHS_WARRANTY,
    "3 year warranty": WarrantyInformation.THE_3_YEAR_WARRANTY,
    "5 year warranty": WarrantyInformation.THE_5_YEAR_WARRANTY,
    "6 months warranty": WarrantyInformation.THE_6_MONTHS_WARRANTY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
