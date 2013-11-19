SensorModel = require('models/sensors-model');

module.exports = SensorCollection = Backbone.Collection.extend({
    url: 'http://127.0.0.1:4000/sensor/',
    model : SensorModel
});
