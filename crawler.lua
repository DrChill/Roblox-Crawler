---
-- Program: Roblox.com Crawler
-- Author: DrChill
-- Created: Dec. 14, 2013
---

web = require 'web'

local homePage = 'http://www.roblox.com'
local version = 0.1

print("============================")
print("Starting Roblox Crawler v" .. version)
print("============================")

local page = web.http.get(homePage)
local links = web.extractLinks(page)

-- links = web.makeLinksAbsolute(links, homePage)

for i=1, #links do
	print(links[i])
end

