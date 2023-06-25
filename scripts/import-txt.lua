-- Import tracks from .txt file

sqlite3 = require 'lsqlite3'
local dbfile = 'database.sqlite3'

local db = sqlite3.open(dbfile)

function split(s)
  for title, artist in s:gmatch('(.+)  (.+)') do
    return title, artist
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

db:exec([[SELECT COUNT(*) FROM tracks]], function(udata, cols, values, names)
  print('Inserted ' .. values[1] .. ' rows')
end)

db:close()
