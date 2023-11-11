class Resort {
  List<Banner> banners;
  bool status;
  List<Category> category;
  List<ResortData> resort;

  Resort(
      {required this.banners,
      required this.status,
      required this.category,
      required this.resort});

  factory Resort.fromJson(Map<String, dynamic> json) {
    return Resort(
      banners:
          List<Banner>.from(json['banners'].map((x) => Banner.fromJson(x))),
      status: json['status'],
      category: List<Category>.from(
          json['category'].map((x) => Category.fromJson(x))),
      resort: List<ResortData>.from(
          json['resort'].map((x) => ResortData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banners': List<dynamic>.from(banners.map((x) => x.toJson())),
      'status': status,
      'category': List<dynamic>.from(category.map((x) => x.toJson())),
      'resort': List<dynamic>.from(resort.map((x) => x.toJson())),
    };
  }
}

class Banner {
  String id;
  String title;
  String image;
  String description;
  bool isDelete;
  int v;

  Banner({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.isDelete,
    required this.v,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      isDelete: json['is_delete'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      'is_delete': isDelete,
      '__v': v,
    };
  }
}

class Category {
  String id;
  String name;
  String description;
  String image;
  List<dynamic> resortID;
  bool isDelete;
  int v;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.resortID,
    required this.isDelete,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      resortID: json['resortID'],
      isDelete: json['is_delete'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
      'resortID': resortID,
      'is_delete': isDelete,
      '__v': v,
    };
  }
}

class ResortData {
  Location location;
  String id;
  String resortowner;
  String resortname;
  int capacity;
  String description;
  List<String> image;
  int price;
  bool verify;
  int phone;
  String status;
  String category;
  bool isDelete;
  bool isBlocked;
  List<Adventure> adventure;
  int v;
  List<String> services;
  List<Review> reviews;
  List<dynamic> notification;

  ResortData({
    required this.location,
    required this.id,
    required this.resortowner,
    required this.resortname,
    required this.capacity,
    required this.description,
    required this.image,
    required this.price,
    required this.verify,
    required this.phone,
    required this.status,
    required this.category,
    required this.isDelete,
    required this.isBlocked,
    required this.adventure,
    required this.v,
    required this.services,
    required this.reviews,
    required this.notification,
  });

  factory ResortData.fromJson(Map<String, dynamic> json) {
    return ResortData(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      resortowner: json['resortowner'],
      resortname: json['resortname'],
      capacity: json['capacity'],
      description: json['description'],
      image: List<String>.from(json['image'].map((x) => x)),
      price: json['price'],
      verify: json['verify'],
      phone: json['phone'],
      status: json['status'],
      category: json['category'],
      isDelete: json['is_delete'],
      isBlocked: json['is_blocked'],
      adventure: List<Adventure>.from(
          json['adventure'].map((x) => Adventure.fromJson(x))),
      v: json['__v'],
      services: List<String>.from(json['services'].map((x) => x)),
      reviews:
          List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
      notification: List<dynamic>.from(json['notification'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      '_id': id,
      'resortowner': resortowner,
      'resortname': resortname,
      'capacity': capacity,
      'description': description,
      'image': List<dynamic>.from(image.map((x) => x)),
      'price': price,
      'verify': verify,
      'phone': phone,
      'status': status,
      'category': category,
      'is_delete': isDelete,
      'is_blocked': isBlocked,
      'adventure': List<dynamic>.from(adventure.map((x) => x.toJson())),
      '__v': v,
      'services': List<dynamic>.from(services.map((x) => x)),
      'reviews': List<dynamic>.from(reviews.map((x) => x.toJson())),
      'notification': List<dynamic>.from(notification.map((x) => x)),
    };
  }
}

class Location {
  String district;
  String place;

  Location({
    required this.district,
    required this.place,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      district: json['district'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'district': district,
      'place': place,
    };
  }
}

class Adventure {
  bool isDelete;
  String name;
  String description;
  int time;
  List<String> image;
  String id;

  Adventure({
    required this.isDelete,
    required this.name,
    required this.description,
    required this.time,
    required this.image,
    required this.id,
  });

  factory Adventure.fromJson(Map<String, dynamic> json) {
    return Adventure(
      isDelete: json['is_delete'],
      name: json['name'],
      description: json['description'],
      time: json['time'],
      image: List<String>.from(json['image'].map((x) => x)),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_delete': isDelete,
      'name': name,
      'description': description,
      'time': time,
      'image': List<dynamic>.from(image.map((x) => x)),
      '_id': id,
    };
  }
}

class Review {
  String userId;
  String userReview;
  int rating;
  DateTime createdDate;
  String id;

  Review({
    required this.userId,
    required this.userReview,
    required this.rating,
    required this.createdDate,
    required this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'],
      userReview: json['userReview'],
      rating: json['rating'],
      createdDate: DateTime.parse(json['createdDate']),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userReview': userReview,
      'rating': rating,
      'createdDate': createdDate.toIso8601String(),
      '_id': id,
    };
  }
}
