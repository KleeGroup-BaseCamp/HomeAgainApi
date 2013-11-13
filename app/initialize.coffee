# App Namespace
App =
    Routers: {}
    Views: {}
    Models: {}
    Collections: {}
    Sockets: {}

module.exports = _.extend App, Backbone.Events

$ ->
    
    # App is an Event Emmiter / mediator
    App.on 'initialize', (msg) ->
        console.log msg

    # Initialize App
    App.Views.AppView = new AppView = require 'views/app_view'

    # Initialize Router
    App.Routers.AppRouter = new AppRouter = require 'routers/app_router'

    # Initialize Backbone History
    Backbone.history.start
        pushState: true

    $(document).on "click", "a[href]:not([data-bypass])", (evt) ->
        # Get the absolute anchor href.
        # @router.previousRoute = location.href
        href =
          prop: $(this).prop("href")
          attr: $(this).attr("href")
        # Get the absolute root.
        root = location.protocol + "//" + location.host # + config.approot
        
        # Ensure the root is part of the anchor href, meaning it's relative.
        if href.prop.slice(0, root.length) is root
        # Stop the default event to ensure the link will not cause a page
            # refresh.
            evt.preventDefault()
            # `Backbone.history.navigate` is sufficient
            #for all Routers and will
            # trigger the correct events. The Router's
            #internal `navigate` method
            # calls this anyways.  The fragment is sliced from the root.
            Backbone.history.navigate(href.attr, true)


    # trigger the initialize event for the app
    App.trigger 'initialize', 'Backbone App initialized...', App

    if io
        App.Sockets.AppSocket = io.connect '/app'
        App.Sockets.AppSocket.on 'msg', (msg) ->
            console.log 'Socket.io Msg: '+msg
        App.Sockets.AppSocket.emit 'initialize'
