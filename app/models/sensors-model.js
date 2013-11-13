module.exports = SensorModel = Backbone.Model.extend({
    urlRoot: 'http://localhost:4000/sensor/',
    idAttribute: 'sensor_id',
    defaults : {
        name: 'MySensor',
    },
});
