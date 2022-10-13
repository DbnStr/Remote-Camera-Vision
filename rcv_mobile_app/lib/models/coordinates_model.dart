class Coordinates {

  final int? top;
  final int? bottom;
  final int? left;
  final int? right;

  Coordinates(this.top, this.bottom, this.left, this.right);

  Coordinates.fromJson(Map<String, dynamic> json)
    : this(
      json['top'] as int,
      json['bottom'] as int,
      json['left'] as int,
      json['right'] as int
    );

  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'bottom': bottom,
      'left': left,
      'right': right
    };
  }
}