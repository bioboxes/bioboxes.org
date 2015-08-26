publish: build
	bundle exec middleman s3_sync

test: build
	bundle exec htmlproof --check-html --check-favicon --href-ignore '#' $<
	bundle exec ./plumbing/check-forbidden-words forbidden.txt $(shell find $< -name "*index.html")

build: $(shell find source) $(fetch) Gemfile.lock
	bundle exec middleman build --verbose

dev: $(shell find source) $(fetch) Gemfile.lock
	bundle exec middleman server

clean:
	rm -rf build $(fetch)

###################################
#
# Bootstrap website resources
#
###################################

fetch =  source/tools/validate-biobox-file.mkd source/tools/command-line-interface.mkd

bootstrap: Gemfile.lock \
	   vendor/bootstrap \
	   vendor/javascripts/lodash.min.js \
	   $(fetch)

vendor/javascripts/lodash.min.js:
	mkdir -p $(dir $@)
	wget \
	  --quiet \
	  --output-document $@ \
          https://raw.githubusercontent.com/lodash/lodash/3.10.0/lodash.min.js

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

source/tools/validate-biobox-file.mkd:
	mkdir -p $(dir $@)
	wget \
		--quiet \
		--output-document $@ \
		https://raw.githubusercontent.com/bioboxes/file-validator/master/doc/validate-biobox-file.mkd

source/tools/command-line-interface.mkd:
	mkdir -p $(dir $@)
	wget \
		--quiet \
		--output-document $@ \
	        https://raw.githubusercontent.com/bioboxes/command-line-interface/master/doc/bioboxes-cli.mkd
