if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local getIdx1, sub1, genStream1, peek1, match1, eat1, eatWhile1, skipTo1, skipToEnd1, eol1, next1, backUp1, current1
getIdx1 = function(v1, v2) return v1[v2] end
sub1 = string.sub
genStream1 = (function(string)
	return ({["string"]=string,["start"]=1,["pos"]=1,["peek"]=peek1,["match"]=match1,["eat"]=eat1,["eat-while"]=eatWhile1,["skip-to"]=skipTo1,["skip-to-end"]=skipToEnd1,["eol"]=eol1,["next"]=next1,["back-up"]=backUp1,["current"]=current1})
end)
peek1 = (function(stream)
	local char = sub1(stream["string"], stream["pos"], stream["pos"])
	if char then
		return char
	else
		return nil
	end
end)
match1 = (function()
	return nil
end)
eat1 = (function()
	return nil
end)
eatWhile1 = (function()
	return nil
end)
skipTo1 = (function()
	return nil
end)
skipToEnd1 = (function()
	return nil
end)
eol1 = (function()
	return nil
end)
next1 = (function()
	return nil
end)
backUp1 = (function()
	return nil
end)
current1 = (function()
	return nil
end)
return genStream1("Hey")
