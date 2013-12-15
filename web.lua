-- Http/web stuff

local web = {}

local http = require("socket.http")
local ltn12 = require("ltn12")

web.http = {}
-- @url - string - Url beginning with http:// to download
-- return: returns content of page
function web.http.get(url)
	local response = {}
	socket.http.request(
		{
			url = url,
			method = "GET",
			sink = ltn12.sink.table(response)
		}
	)

	return table.concat(response)
end

-- @page - string -- Page containing links to be extracted
-- return: Returns a table of the urls found in links
function web.extractLinks(page)
	local linkList = {}
	-- Get the raw links from the site
	-- Match all <> containing a
	local pattern = '<%s-a%s.->'
	for l in string.gmatch(page, pattern) do
		-- Find the href part of the link
		s, e = string.find(l, 'href%s-=%s-"')
		if s ~= nil then
			l2 = string.sub(l, e)
			-- Extract the part we need, less the parens
			s, e = string.find(l2, '".-"')
			if s ~= nil then
				linkList[#linkList+1] = string.sub(l2, s+1, e-1)
			end
		end
	end

	-- Now we filter out non-link stuff
	fLinkList = {}
	for i=1, #linkList do
		if linkList[i] == "" then
		elseif linkList[i] == "#" then
		elseif string.sub(linkList[i], 1, 11) == "javascript:" then
		else
			fLinkList[#fLinkList+1] = linkList[i]
		end
	end

	return fLinkList
end

function web.makeLinksAbsolute(links, url)

end

return web
