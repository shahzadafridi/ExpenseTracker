class CategoryModel {
  final String id;
  final String title;
  final String icon;

  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'icon': icon,
  };

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon']
    );
  }
}