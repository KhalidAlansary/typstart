.PHONY: build clean

OUT_DIR := $(shell jq -r '.pages_build_output_dir' wrangler.jsonc)
SRC := src/main.typ

build: $(OUT_DIR)/main.pdf $(OUT_DIR)/main.html $(OUT_DIR)/index.html

$(OUT_DIR):
	mkdir -p $@

$(OUT_DIR)/index.html: index.html | $(OUT_DIR)
	cp $< $@

$(OUT_DIR)/main.pdf: $(SRC) | $(OUT_DIR)
	typst compile $< $@

$(OUT_DIR)/main.html: $(SRC) | $(OUT_DIR)
	typst compile --features=html $< $@

clean:
	rm -rf $(OUT_DIR)
