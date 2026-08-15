class Food {
  int id;
  String name;
  String nameEn;
  String imageUrl;
  double price;
  String description;
  String descriptionEn;
  double rating;
  int ratingCount;
  int restaurantId;
  bool isSoldOut;
  String category; // 'food', 'drink', or 'dessert'

  Food({
    required this.id,
    required this.name,
    this.nameEn = '',
    required this.imageUrl,
    required this.price,
    required this.description,
    this.descriptionEn = '',
    this.rating = 4.5,
    this.ratingCount = 0,
    this.restaurantId = 1,
    this.isSoldOut = false,
    this.category = 'food',
  });
}
