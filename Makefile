test:
	mocha --compilers coffee:coffee-script/register test/integration/api_test.coffee

.PHONY : test
