a = 102;
b = 14;
c = 12;
d = 5;
e = 10;
h = 10;
i = 3;
j = 2;
k = 40;
l = 60;
s = 40;
t = 16;
u = 14;
w = 4;
$fn = 100;

// FIXME: These numbers are hardcoded
_r1 = 49;
_a = 61;
_r2 = _r1 + w;
module _h1() {
  translate ([-(_r2 + 1), 0]) {
    square([2*(_r2 + 1), _r2 + 1]);
  }
}
module _h2() {
  difference() {
    circle(r = _r2);
    circle(r = _r1);
    _h1();
    rotate(90) {
      _h1();
    }
    rotate(-_a) {
      _h1();
    }
  }
}
module _h3() {
  translate([c, _r2 + t/2]) {
    _h2();
  }
  translate([l, -_r2 + t/2 + s/2 - w]) {
    mirror([1, 0]) {
      mirror([0, 1]) {
        _h2();
      }
    }
  }
}

module side_wall() {
  _h3();
  translate([-(a + b) + w/2, t/2 + w/2]) {
    circle(d = w);
  }
  translate([-(a + b) + w/2, t/2]) {
    square([a + b + c - w/2, w]);
  }
  translate([l + k - w/2, s/2 + w/2]) {
    circle(d = w);
  }
  translate([l, s/2]) {
    square([k - w/2, w]);
  }
}
module side_walls() {
  side_wall();
  mirror([0, 1]) {
    side_wall();
  }
}

module _h5() {
  difference() {
    side_wall();
    translate([-(a + b), -(t/2 + w + 1)]) {
      square([w/2 + 1, t + 2*(w + 1)]);
    }
    translate([l, -(s/2 + w + 1)]) {
      square([l + 1, s + 2*(w + 1)]);
    }
  }
}
module _h6() {
  for (x = [0:4]) { // FIXME: Hardcoded index
    translate([0, -x*(w - 1)]) {
      _h5();
    }
  }
}
module plate_hole() {
  circle(d = t);
  translate([0, -t/2, 0]) {
    square([a - 2*u - t, t]);
  }
  translate([(a - 2*u - t), 0]) {
    circle(d = t);
  }
}
module plate() {
  difference() {
    union() {
      _h6();
      mirror([0, 1]) {
        _h6();
      }
      translate([0, -t/2]) {
        square([l, t]);
      }
    }
    translate([-(a - u - t/2), 0]) {
      plate_hole();
    }
    // FIXME: These are hardcoded
    _x = 94;
    _r = 40;
    translate([_x, 0, 0]) {
      circle(r = _r);
    }
  }
}

module hole() {
  translate([0, 0, -1]) {
    cylinder(h = i + 2, d = d);
  }
  translate([0, 0, j]) {
    cylinder(h = i - j + 1, d = e);
  }
}

module hook() {
  difference() {
    union() {
      linear_extrude(height = i) {
        plate();
      }
      linear_extrude(height = h) {
        side_walls();
      }
    }
    hole();
    translate([-a , 0, 0]) {
      hole();
    }
  }
}

module hook_with_helpers() {
  hook();
  // FIXME: helpers are partially hardcoded
  _h = 1;
  _d = 3;
  _e = 10;
  linear_extrude(height = _h) {
    for (i = [0:3]) {
      translate([l + _d + _e*i, -(s/2 + 1)]) {
        square([_h, s + 2]);
      }
    }
    for (i = [0:4]) {
      translate([-(a - u - t) + _e*i, -(t/2 + 1)]) {
        square([_h, t + 2]);
      }
    }
  }
}

hook_with_helpers();
