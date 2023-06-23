sqlite3 = require 'lsqlite3'
dbfile = 'database.sqlite3'

-- db = sqlite3.open(dbfile)

function split(s)
  for a, b in s:gmatch('(.+)  (.+)') do
    return table.unpack({a, b})
  end
end

file = arg[1]
print('Processing ' .. file)

for line in io.lines(arg[1]) do
  -- print(line)
  local title, artist = split(line)
  print(title, '||', artist)
end
