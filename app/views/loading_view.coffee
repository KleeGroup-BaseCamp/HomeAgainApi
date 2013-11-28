View = require 'lib/view'

module.exports = LoadingView = View.extend(
    className: "loading"

    autoRender: off

    template: require 'views/templates/loading_view'
)
