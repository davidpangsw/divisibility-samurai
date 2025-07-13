class Vector {
  final double x;
  final double y;

  const Vector(this.x, this.y);

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);
  Vector operator -(Vector other) => Vector(x - other.x, y - other.y);
  Vector operator *(double scalar) => Vector(x * scalar, y * scalar);

  @override
  String toString() => 'Vector($x, $y)';
  
  @override
  bool operator ==(Object other) =>
      other is Vector && other.x == x && other.y == y;
      
  @override
  int get hashCode => Object.hash(x, y);
}