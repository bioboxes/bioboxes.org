bootstrap: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle
