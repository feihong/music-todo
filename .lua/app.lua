local fm = require "fullmoon"

function makeStorage() return fm.makeStorage('database.sqlite3') end

fm.setRoute(fm.GET"/", function () return [[<!doctype html><html><head><meta charset=utf-8><meta http-equiv=x-ua-compatible content="IE=edge"><meta name=viewport content="width=device-width,minimum-scale=1">
<title>Music Todo</title><script src="https://unpkg.com/htmx.org@1.7.0"></script></head><body>
<h1>Music Todo</h1>
<h2>Tracks</h2>
<div id="tracks" hx-get="/tracks" hx-trigger="load">---</div>
</body></html>]]
end)

fm.setTemplate('tracks', [[
<ol>
{% for _, track in ipairs(tracks) do %}
  <li> {%& track.title %} ~ {%& track.artist %} </li>
{% end %}
</ol>
]])

fm.setRoute(fm.GET"/tracks", function(r)
  local db = makeStorage()
  return fm.serveContent('tracks', { tracks = db:fetchAll([[SELECT * FROM tracks]]) })
end)

fm.run()
