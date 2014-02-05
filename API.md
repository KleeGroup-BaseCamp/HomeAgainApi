# General information about the API

## Authentication

When login to the platform, you will be given a apikey.
You will have to send the apikey with each request that ends with a star in this documentation.

## Installing apidocjs

    sudo npm install -g git+ssh://git@github.com:nmalzieu/apidoc.git

Then launch

    apidoc -f ".*\\.js$" -f ".*\\.coffee$" -i express/routes/
