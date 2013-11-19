module.exports = RoomModel = Backbone.Model.extend({
    urlRoot: 'http://localhost:4000/room/',
    idAttribute: 'room_id',
    defaults : {
        name: 'MyRoom',
    },
    schema: {
        name: 'Text',
    }
});
