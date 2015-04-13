publish: build
	bundle exec middleman s3_sync

test: build
	bundle exec htmlproof $<
	bundle exec ./plumbing/check-forbidden-words forbidden.txt $(shell find $< -name "*index.html")

build: $(shell find source) Gemfile.lock
	bundle exec middleman build --verbose

dev: $(shell find source) Gemfile.lock
	bundle exec middleman server

clean:
	rm -rf build

###################################
#
# Bootstrap website resources
#
###################################

fetch =  source/validate-input.mkd source/validator/short-read-assembler.mkd

bootstrap: Gemfile.lock vendor/bootstrap $(fetch)

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

###################################
#
# Fetched pages from external tools
#
###################################

source/validate-input.mkd:
	wget \
		--quiet \
		--output-document $@ \
		https://raw.githubusercontent.com/bioboxes/input-validator/master/doc/validate-input.mkd

source/validator/short-read-assembler.mkd:
	mkdir -p $(dir $@)
	wget \
		--quiet \
		--output-document $@ \
		https://raw.githubusercontent.com/bioboxes/validator-short-read-assembler/master/doc/short-read-assembler-validator.md


