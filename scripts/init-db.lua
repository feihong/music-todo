sqlite3 = require 'lsqlite3'
dbfile = 'database.sqlite3'

if not path.exists(dbfile) then
  db = sqlite3.open(dbfile)
  db:exec[[
    CREATE TABLE tracks (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      artist TEXT NOT NULL,
      status TEXT,
      collect INTEGER,
      lyrics TEXT,
      link TEXT,
      notes TEXT
    );
  ]]
end
