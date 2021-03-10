module penrose3(angle, side, height = 1.5, perimeter_width = 0.6, perimeter_depth = 0.9) {
  x = side * cos(0.5 * angle);
  y = side * sin(0.5 * angle);
  linear_extrude(height = height - perimeter_depth) {
    polygon([
      [-x, 0],
      [0, y],
      [x, 0],
      [0, -y]]);
  }
  xp = x - perimeter_width / sin(0.5 * angle);
  yp = y - perimeter_width / cos(0.5 * angle);
  linear_extrude(height = height) {
    polygon([
      [-xp, 0],
      [0, yp],
      [xp, 0],
      [0, -yp]]);
  }
  echo(angle=angle, side=side, x=x, y=y);
}

penrose3(72, 30); // Fat
// penrose3(36, 30); // Thin
