bootstrap: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

build: $(shell find source) Gemfile.lock
	rm -fr $@
	bundle exec middleman build --verbose

clean:
	rm -rf build
