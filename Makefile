test:
	find ./test -name "*.coffee" | xargs mocha --compilers coffee:coffee-script/register

.PHONY : test
