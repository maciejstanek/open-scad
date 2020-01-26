GENERATOR=generate.py
.PHONY: scad stl clean

scad: mold.scad vase.scad

%.scad: $(GENERATOR)
	./$(GENERATOR) \
    --hole-diameter=105 \
    --hole-depth=85 \
    --height=105 \
    --wall=1 \
    --diameter=145 \
    --sides=20 \
    --component=$* \
    > $@

stl: mold.stl vase.stl

%.stl: %.scad
	openscad $< -o $@

clean:
	rm -f *.scad
	rm -f *.stl
