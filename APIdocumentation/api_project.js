define({
  "name": "HomeAgainAPI",
  "version": "0.0.1",
  "description": "HomeAgain is an Open Source project that lets programmers use all sorts of home sensors to build valuable services for consumers. Here is its API documentation.",
  "apidoc": "<h1 id=\"general-information-about-the-api\">General information about the API</h1>\n<h2 id=\"authentication\">Authentication</h2>\n<p>When login to the platform, you will be given a apikey.\nYou will have to send the apikey with each request that ends with a star in this API documentation.</p>\n<h2 id=\"installing-apidocjs\">Installing apidocjs</h2>\n<pre><code>sudo npm install -g git+ssh://git@github.com:nmalzieu/apidoc.git\n</code></pre><p>Then launch</p>\n<pre><code>apidoc -f &quot;.*\\\\.js$&quot; -f &quot;.*\\\\.coffee$&quot; -i express/routes/\n</code></pre>",
  "generator": {
    "version": "0.4.2",
    "time": "2014-03-19T20:51:00.356Z"
  }
});