publish: build
	bundle exec middleman s3_sync

test: build
	bundle exec htmlproof $<
	bundle exec ./plumbing/check-forbidden-words forbidden.txt $(shell find $< -name "*index.html")

build: $(shell find source) Gemfile.lock
	bundle exec middleman build --verbose

dev: $(shell find source) Gemfile.lock
	bundle exec middleman server


bootstrap: Gemfile.lock vendor/bootstrap source/validate-input.mkd

source/validate-input.mkd:
	wget \
		--quiet \
		--output-document $@ \
		https://raw.githubusercontent.com/bioboxes/input-validator/master/doc/validate-input.mkd

vendor/bootstrap:
	mkdir -p vendor
	wget \
	  --quiet \
	  --output-document bootstrap.zip \
	  https://github.com/twbs/bootstrap/archive/v3.3.4.zip
	unzip bootstrap.zip
	mv bootstrap-3.3.4 $@
	rm bootstrap.zip
	touch $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

clean:
	rm -rf build
