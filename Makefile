TESTIMONIALS := $(patsubst testimonials/%.md,dist/testimonials/%.json,$(wildcard testimonials/*.md))

.PHONY: all deploy testimonial

all: node_modules dist/testimonials.json

node_modules: package.json yarn.lock
	yarn

dist/testimonials.json: $(TESTIMONIALS)
	@mkdir -p dist
	bin/build-indexes $@ $(TESTIMONIALS)

dist/testimonials/%.json: testimonials/%.md
	@mkdir -p dist/testimonials
	bin/convert-to-json $< > $@

deploy: all
	-git add dist
	-git commit -m "Update gh-pages"
	git push -f origin gh-pages:gh-pages

testimonial:
	bin/create-testimonial
