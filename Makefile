publish: build
	bundle exec middleman s3_sync

test: build
	bundle exec htmlproof $<

build: $(shell find source) Gemfile.lock
	bundle exec middleman build --verbose

dev: $(shell find source) Gemfile.lock
	bundle exec middleman server


bootstrap: Gemfile.lock vendor/bootstrap

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
