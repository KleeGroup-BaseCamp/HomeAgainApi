define({ api: [
  {
    "type": "get",
    "url": "/sensors/",
    "title": "Read the list of sensors*",
    "name": "GetSensors",
    "group": "Sensors",
    "description": "This request gives the list of sensors of the user.",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Sensor[]",
            "field": "(No-Name",
            "optional": false,
            "description": ")          List of <code>sensors</code>, see <code>/sensors/:id</code> for a detailed structure."
          }
        ]
      }
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "field": "NoApikey",
            "optional": false,
            "description": "No apikey was sent with the request."
          },
          {
            "group": "Error 4xx",
            "field": "NoAccessRight",
            "optional": false,
            "description": "Wrong apikey."
          }
        ]
      }
    },
    "version": "0.0.0",
    "filename": "express/routes/sensor.coffee"
  },
  {
    "type": "get",
    "url": "/sensors/:identifier",
    "title": "Read data of a sensor*",
    "name": "GetSensorsId",
    "group": "Sensors",
    "description": "This request gives you information about a given sensor, for the user who is logged in.",
    "examples": [
      {
        "title": "Example usage:",
        "content": "  curl -i http://homeagain.io/sensors/23?api_key=8264823&datastart=1391631304&datastop=1391631800\n"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "field": "identifier",
            "optional": false,
            "description": "<code>identifier</code> of the sensor."
          },
          {
            "group": "Parameter",
            "type": "Date",
            "field": "datastart",
            "optional": true,
            "description": "Beginning of the period you want to get data from."
          },
          {
            "group": "Parameter",
            "type": "Date",
            "field": "dataend",
            "optional": true,
            "description": "End of the period you want to get data from."
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "field": "identifier",
            "optional": false,
            "description": "<code>id</code> of the sensor."
          },
          {
            "group": "Success 200",
            "type": "String",
            "field": "name",
            "optional": false,
            "description": "Name of the sensor."
          },
          {
            "group": "Success 200",
            "type": "Type",
            "field": "model",
            "optional": false,
            "description": "Model used for the sensor (with a <code>name</code> argument)"
          },
          {
            "group": "Success 200",
            "type": "Id",
            "field": "hub",
            "optional": false,
            "description": "ObjectId of the Hub to which this sensor is linked"
          },
          {
            "group": "Success 200",
            "type": "Date",
            "field": "created_on",
            "optional": false,
            "description": "Date the sensor was created on"
          },
          {
            "group": "Success 200",
            "type": "Id",
            "field": "room",
            "optional": false,
            "description": "ObjectId of the room the sensor is assigned to"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 OK\n  {\n      \"identifier\": \"MOISTURE_3\",\n      \"model\": {\n          \"name\": \"moisture\",\n          \"_id\": \"5329b7fcb5cc66dd9d79c2f9\",\n          \"__v\": 0\n      },\n      \"hub\": \"5329b7fcb5cc66dd9d79c2f2\",\n      \"created_on\": \"2014-02-05T22:07:23.073Z\",\n      \"room\": \"5329b7fcb5cc66dd9d79c2f4\",\n      \"_id\": \"5329b7fcb5cc66dd9d79c308\",\n      \"__v\": 0,\n      \"data\": []\n  }\n"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "field": "IdNotFound",
            "optional": false,
            "description": "The <code>id</code> of the sensor was not found."
          },
          {
            "group": "Error 4xx",
            "field": "NoApikey",
            "optional": false,
            "description": "No apikey was sent with the request."
          },
          {
            "group": "Error 4xx",
            "field": "NoAccessRight",
            "optional": false,
            "description": "Wrong apikey."
          },
          {
            "group": "Error 4xx",
            "field": "WrongDatastart",
            "optional": false,
            "description": "datastart is at wrong format - should be a timestamp"
          },
          {
            "group": "Error 4xx",
            "field": "WrongDatastop",
            "optional": false,
            "description": "datastop is at wrong format - should be a timestamp"
          },
          {
            "group": "Error 4xx",
            "field": "NoDatastart",
            "optional": false,
            "description": "datastop was given with no datastart"
          },
          {
            "group": "Error 4xx",
            "field": "NoDatastop",
            "optional": false,
            "description": "datastart was given with no datastop"
          }
        ]
      }
    },
    "version": "0.0.0",
    "filename": "express/routes/sensor.coffee"
  },
  {
    "type": "post",
    "url": "/login/",
    "title": "Login to HomeAgain",
    "name": "PostUser",
    "group": "User",
    "examples": [
      {
        "title": "Example usage:",
        "content": "curl -i \\\n    -H \"Content-Type: application/json\" \\\n    -d '{\"username\":\"user\", \"password\":\"password\"}' \\\n    \"http://homeagain.io/login\"\n"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "field": "username",
            "optional": false,
            "description": "<code>username</code> of the User."
          },
          {
            "group": "Parameter",
            "type": "String",
            "field": "password",
            "optional": false,
            "description": "Password of the User."
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "field": "user_id",
            "optional": false,
            "description": "<code>user_id</code> of the User (ObjectId)"
          },
          {
            "group": "Success 200",
            "type": "String",
            "field": "api_key",
            "optional": false,
            "description": "APIkey that needs to be sent along with each request with a star."
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 OK\n  {\n    \"id\": \"23\"\n    \"api_key\": \"785876\"\n  }\n"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "field": "IdNotFound",
            "optional": false,
            "description": "The <code>id</code> of the User was not found."
          },
          {
            "group": "Error 4xx",
            "field": "WrongPassword",
            "optional": false,
            "description": "The password is wrong."
          }
        ]
      }
    },
    "version": "0.0.0",
    "filename": "express/routes/login.coffee"
  }
] });