HomeAgain - Installation tutorial
-------

This tutorial will teach you how to set up the following :

* AdminApp
* MonitoringApp
* HomeAgain API
* HomePi simulator
* HomeDuino

This enables you to simulate the full value chain of the HomeAgain project and start playing with it!

### Requirements

To follow this tutorial, you need to have already installed :

* [NodeJS](http://nodejs.org/)
* [MongoDB](http://www.mongodb.org/)



Install the HomeAgain API
---



### 1. Set up the API

In the directory where you want to install the code:

* Clone the repo : `git clone git@github.com:HomeAgain/HomeAgainApi.git`

* `cd ./HomeAgainApi`


* Install npm dependencies : `npm install`
 
* Make sure mongoDB is running on port `27017` (default). Otherwise you need to edit the file `express/models/models.coffee` according to your configuration

* Install the fixtures `coffee fixtures`

* Finally launch the express server : `coffee express/index.coffee` 

By default the API is configured to run on `http://localhost:4000/`.

To test it, in your browser go to `http://localhost:4000/sensors?user_id=YOUR_USER_ID&apikey=abcdef` to see the JSON list of default sensors.

You can retrieve `YOUR_USER_ID` in your Mongo DB, it corresponds to the ObjectID of the default user "test".


### 2. Install the API doc

If you want to generate a local copy of the API doc,

* Install apidocJS : `npm install apidoc`

* Run `apidoc -f ".*\\.js$" -f ".*\\.coffee$" -i express/routes/` to generate the documention.

* The HTML versions of the doc is then available at `./doc/index.html`



Install the AdminApp/MonitoringApp
---

In the directory where you want to install the code:

* Install Brunch `npm install -g brunch`

* Install Bower `npm install -g bower`

* Clone the repo : `git clone git@github.com:HomeAgain/AdminApp.git`

* Install npm dependencies : `npm install`

* Install bower dependencies : `bower install`

* Make sure the HomeAgain API is running at `http://localhost:4000/` 

* Launch the AdminApp : `brunch w -s` or `brunch watch -server`

You can now access the AdminApp at `http://localhost:3333/signin` the default credentials are login : `test`/ password : `test`

To install the MonitoringApp, follow the exact same steps but clone the following repository instead : `git@github.com:HomeAgain/MonitoringApp.git`



Install the HomePi
---


In the directory where you want to install the code:

* CLone the repo : git@github.com:HomeAgain/HomePi.git

* Install npm dependencies : `npm install`


If you want to simulate the HomeDuino for data generation, ensure `DEBUG = true;`in `./apps.js`
If you use a separate HomeDuino (see below for instruction) ensure `DEBUG=false`;

* Launch the HomePi `node app.js`

By default the HomePi will try to report to an instance of HomeAgain API at `http://locahost:4000`. You can change this value in `./apps.js`


Install the HomeDuino
---

To use an Arduino as HomeDuino you need : 

* An Arduino UNO R3
* A Grove Shield
* Some Grove sensors

Currently the supported sensors are Temperature, Moisture and Water sensors.


To set up the HomeDuino :

* Clone the repo : `git@github.com:HomeAgain/HomeDuino.git`

* Open `./HomeDuino.ino` in your favorite Arduino IDE

* Comment/Uncomment the first `#define` lines to match your Arduino configuration:
	* `#define TEMPERATURE_SENSOR` indicates the presence of a temperature sensors
	* `#define TEMPERATURE_PIN 0` indicates on which analog port of the Grove shield it's connected
	


To connect the HomeDuino to an HomePi you must :

* Connect both with an USB cable
* Change the HomePi configuration to `DEBUG = false;`
* Change the HomePi serial port configuration in `./apps.js` to the USB-to-serial port, by default `/dev/tty.usbmodem1411`
* Launch the HomePi node server `node apps.js`



 

 