module.exports = SensorModel = Backbone.Model.extend({
    urlRoot: 'http://localhost:4000/sensor/',
    idAttribute: 'sensor_id',
    defaults : {
        name: 'MySensor',
        sensor_id: "",
    },
    schema: {
        name: 'Text',
        sensor_id: { editorAttrs: { disabled: true } },
        model: { type: 'Select', options: ['temperature', 'door'],  editorAttrs: { disabled: true }},
    }
});
