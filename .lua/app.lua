local fm = require "fullmoon"

function makeStorage() return fm.makeStorage('database.sqlite3') end

fm.setRoute('/*.css', fm.serveAsset)


fm.setRoute(fm.GET"/", function () return [[<!doctype html><html><head><meta charset=utf-8><meta http-equiv=x-ua-compatible content="IE=edge"><meta name=viewport content="width=device-width,minimum-scale=1">
<title>Music Todo</title>
<link rel="stylesheet" href="/pure-min.css">
<link rel="stylesheet" href="/styles.css">
<script src="https://unpkg.com/htmx.org@1.7.0"></script>
</head><body>
<h1>Music Todo</h1>
<main id="main" hx-get="/tracks" hx-trigger="load">---</div>
</body></html>]]
end)

fm.setTemplate('tracks', [[
<h2>Tracks ({%= #tracks %})</h2>
<table>
  <thead>
    <tr>
      <th>title</th>
      <th>artist<th>
    </tr>
  </thead>
  <tbody>
  {% for _, track in ipairs(tracks) do %}
    <tr hx-get="/tracks/{%= track.id %}" hx-trigger="click" hx-target="#main">
      <td> {%& track.title %} </td>
      <td> {%& track.artist %} </td>
    </tr>
  {% end %}
  </tbody>
</table>
]])

fm.setRoute('/tracks', function(r)
  local db = makeStorage()
  return fm.serveContent('tracks', { tracks = db:fetchAll([[SELECT * FROM tracks]]) })
end)

fm.setTemplate('track', [[
<h2> <span hx-trigger="click" hx-get="/tracks" hx-target="main">⇐</span> {%& track.title %}</h2>

Artist: {%= track.artist %}<br>
]])

fm.setRoute('/tracks/:id', function(r)
  local db = makeStorage()
  return fm.serveContent('track', { track = db:fetchOne([[SELECT * FROM tracks WHERE id = ?]], r.params.id) })
end)

fm.run()
