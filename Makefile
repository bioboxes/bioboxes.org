publish: build
	bundle exec middleman s3_sync

build: $(shell find source) Gemfile.lock
	rm -fr $@
	bundle exec middleman build --verbose

dev: $(shell find source) Gemfile.lock
	bundle exec middleman server

bootstrap: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

clean:
	rm -rf build
