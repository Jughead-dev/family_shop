import 'package:floor/floor.dart';

@Entity(tableName: 'like_table')
class Like {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final int productId; 
  final bool isLiked; 
  Like({
    required this.id,
    required this.productId,
    required this.isLiked,
  });
}
