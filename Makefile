install:
	curl -o redbean.com https://redbean.dev/redbean-2.2.com && chmod +x redbean.com && ./redbean.com -v

add:
	zip redbean.com .init.lua .lua/*.lua *.css

start: add
	./redbean.com

init:
	./redbean.com -i scripts/init-db.lua
