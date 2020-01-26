GENERATOR = generate.py
MODELS = mold vase
.PHONY: scad stl clean

scad: $(MODELS:%=%.scad)

%.scad: $(GENERATOR)
	./$(GENERATOR) \
    --hole-diameter=105 \
    --hole-depth=86 \
    --height=105 \
    --wall=0.8 \
    --diameter=145 \
    --sides=20 \
    --component=$* \
    > $@

stl: $(MODELS:%=%.stl)

%.stl: %.scad
	openscad $< -o $@

clean:
	rm -f *.scad
	rm -f *.stl
