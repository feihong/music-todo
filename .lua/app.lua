local fm = require "fullmoon"

fm.setTemplate("hello", "Hello, {%& name %}")

fm.setRoute("/hello/:name", function(r)
    return fm.serveContent("hello", {name = r.params.name})
  end)

fm.run()
