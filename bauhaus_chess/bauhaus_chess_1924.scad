square_side = 20;
piece_square_ratio = 0.7;
piece_side = piece_square_ratio * square_side;
pawn_piece_ratio = 0.75;
pawn_side = pawn_piece_ratio * piece_side;

module pawn() {
  translate([-pawn_side/2, -pawn_side/2, 0]) {
    cube([pawn_side, pawn_side, pawn_side]);
  }
}

module rook() {
  translate([-piece_side/2, -piece_side/2, 0]) {
    cube([piece_side, piece_side, piece_side]);
  }
}

module knight() {
  difference() {
    translate([-piece_side/2, -piece_side/2, 0]) {
      cube([piece_side, piece_side, piece_side]);
    }
    translate([0, 0, piece_side/2]) {
      cube([piece_side, piece_side, piece_side]);
    }
    rotate([0, 0, 270]) {
      translate([0, 0, piece_side]) {
        rotate([180, 0, 0]) {
          translate([0, 0, piece_side/2]) {
            cube([piece_side, piece_side, piece_side]);
          }
        }
      }
    }
  }
}

module bishop() {
  difference() {
    translate([-piece_side/2, -piece_side/2, 0]) {
      cube([piece_side, piece_side, piece_side]);
    }
    for (a = [0:90:270]) {
      rotate([0, 0, a]) {
        translate([0, piece_side, 0]) {
          rotate([0, 0, 45]) {
            translate([-piece_side/2, -piece_side/2, -piece_side/2]) {
              cube([piece_side, piece_side, 2*piece_side]);
            }
          }
        }
      }
    }
  }
}

module king(variant = 0) {
  translate([-piece_side/2, -piece_side/2, 0]) {
    cube([piece_side, piece_side, piece_side]);
  }
  linear_extrude(height = (variant == 1 ? 1.5 : 2) * piece_side) {
    scale(piece_side/2) {
      polygon([[1, 0], [0, 1], [-1, 0], [0, -1]]);
    }
  }
}

module queen(variant = 0) {
  translate([-piece_side/2, -piece_side/2, 0]) {
    cube([piece_side, piece_side, piece_side]);
  }
  if (variant != 1) {
    cylinder(d = 0.3*piece_side, h = 1.5*piece_side, $fn = 100);
  }
  translate([0, 0, (variant == 1 ? 1 : 1.5) * piece_side]) {
    sphere(d = piece_side, $fn = 100);
  }
}

module _chessboard() {
  // Not for printing
  for (i = [0:7]) {
    for (j = [0:7]) {
      square_color = (i + j) % 2 ? "white" : "DarkSlateGrey";
      color (square_color) {
        translate([i * square_side, j * square_side]) {
          square([square_side, square_side]);
        }
      }
    }
  }
}

module _chess_set(variant = 0) {
  // Not for printing
  translate([square_side/2, square_side/2, 0]) {
    translate([0, square_side, 0]) {
      for (i = [0:7]) {
        translate([i * square_side, 0, 0]) {
          pawn();
        }
      }
    }
    rook();
    translate([1 * square_side, 0, 0]) {
      knight();
    }
    translate([2 * square_side, 0, 0]) {
      bishop();
    }
    translate([3 * square_side, 0, 0]) {
      queen(variant);
    }
    translate([4 * square_side, 0, 0]) {
      king(variant);
    }
    translate([5 * square_side, 0, 0]) {
      bishop();
    }
    translate([6 * square_side, 0, 0]) {
      knight();
    }
    translate([7 * square_side, 0, 0]) {
      rook();
    }
  }
}

module _demo(variant = 0) {
  _chessboard();
  color(c = [0.9, 0.9, 0.9]) {
    _chess_set(variant);
  }
  color(c = [0.05, 0.05, 0.05]) {
    translate([8 * square_side, 8 * square_side, 0]) {
      rotate([0, 0, 180]) {
        _chess_set(variant);
      }
    }
  }
}

_demo(1);
