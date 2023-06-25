-- Create database file (if it doesn't exit) and create the tracks table

sqlite3 = require 'lsqlite3'
local dbfile = 'database.sqlite3'

if not path.exists(dbfile) then
  local db = sqlite3.open(dbfile)
  db:exec[[
    CREATE TABLE tracks (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      artist TEXT NOT NULL,
      status TEXT,
      collected INTEGER,
      language TEXT,
      lyrics TEXT,
      link TEXT,
      notes TEXT
    );
  ]]
  db:close()
  print('Generated ' .. dbfile)
else
  print(dbfile .. ' already exists')
end
