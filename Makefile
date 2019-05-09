clean:
	rm -rf .librarian .tmp test Puppetfile.lock

forge:
	bundle exec librarian-puppet install --path test --no-use-v1-api

cdn:
	CDN=1 bundle exec librarian-puppet install --path test --no-use-v1-api

perftest:
	multitime -n 5 -r "make clean > /dev/null" -qq make forge
	multitime -n 5 -r "make clean > /dev/null" -qq make cdn

.PHONY: clean forge cdn perftest
