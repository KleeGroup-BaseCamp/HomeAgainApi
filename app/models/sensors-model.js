module.exports = SensorModel = Backbone.Model.extend({
    urlRoot: 'http://localhost:4000/sensor/',
    idAttribute: 'sensor_id',
    defaults : {
        name: 'MySensor',
    },
    schema: {
        name: 'Text',
        sensor_id: 'Text',
        model: { type: 'Select', options: ['temperature', 'door'] },
    }
});
