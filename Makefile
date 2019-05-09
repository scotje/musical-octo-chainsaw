clean:
	rm -rf .librarian .tmp test Puppetfile.lock r10k-cache

forge:
	bundle exec librarian-puppet install --path test --no-use-v1-api

cdn:
	CDN=1 bundle exec librarian-puppet install --path test --no-use-v1-api

perftest:
	multitime -n 5 -r "make clean > /dev/null" -qq make forge
	multitime -n 5 -r "make clean > /dev/null" -qq make cdn

forge-r10k:
	bundle exec r10k puppetfile install --moduledir test --config r10k.yaml

cdn-r10k:
	bundle exec r10k puppetfile install --moduledir test --config r10k-cdn.yaml

perftest-r10k:
	multitime -n 5 -r "make clean > /dev/null" -qq make forge-r10k
	multitime -n 5 -r "make clean > /dev/null" -qq make cdn-r10k

.PHONY: clean forge cdn perftest
