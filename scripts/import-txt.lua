sqlite3 = require 'lsqlite3'
dbfile = 'database.sqlite3'

db = sqlite3.open(dbfile)

function split(s)
  for a, b in s:gmatch('(.+)  (.+)') do
    return table.unpack({a, b})
  end
end

file = arg[1]
print('Processing ' .. file)

insertStmt = db:prepare[[
  INSERT INTO tracks (title, artist) VALUES (?, ?)
]]

for line in io.lines(file) do
  local title, artist = split(line)
  insertStmt:reset()
  insertStmt:bind_values(title, artist)
  insertStmt:step()
end

db:close()
