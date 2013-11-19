module.exports = SensorModel = Backbone.Model.extend({
    urlRoot: 'http://localhost:4000/sensor/',
    idAttribute: 'sensor_id',
    defaults : {
        name: 'MySensor',
        sensor_id: "",
        room: "",
    },
    schema: {
        name: 'Text',
        sensor_id: { editorAttrs: { disabled: true } },
        model: { type: 'Select', options: ['temperature', 'door'],  editorAttrs: { disabled: true }},
        room: {type: 'Select', options: function(){
            var options = [];
            $.getJSON(
                'http://localhost:4000/room/',
                function(rooms){
                    rooms.forEach(function(room){
                        options.push({ val: room['_id'], label: room['name'] });
                    });
                }
            );
            return options;
        }()},
    }
});
