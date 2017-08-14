if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c3d_1, _2b_1, _2e2e_1, len_23_1, getmetatable1, next1, print1, getIdx1, setIdx_21_1, tostring1, type_23_1, n1, find1, format1, concat1, cons1, pretty1, display1
_3d_1 = function(v1, v2) return v1 == v2 end
_2f3d_1 = function(v1, v2) return v1 ~= v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_2b_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
_2e2e_1 = function(...) local n = _select('#', ...) local t = _select(n, ...) for i = n - 1, 1, -1 do t = _select(i, ...) .. t end return t end
len_23_1 = function(v1) return #v1 end
getmetatable1 = getmetatable
next1 = next
print1 = print
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
tostring1 = tostring
type_23_1 = type
n1 = (function(x)
	if type_23_1(x) == "table" then
		return x["n"]
	else
		return #x
	end
end)
find1 = string.find
format1 = string.format
concat1 = table.concat
cons1 = (function(x, xs)
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_result[1 + _offset] = x
	_temp = xs
	for _c = 1, _temp.n do _result[1 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 1
	return _result
end)
pretty1 = (function(value)
	local ty = type_23_1(value)
	if ty == "table" then
		local tag = value["tag"]
		if tag == "list" then
			local out = ({tag = "list", n = 0})
			local temp = n1(value)
			local temp1 = 1
			while temp1 <= temp do
				out[temp1] = pretty1(value[temp1])
				temp1 = temp1 + 1
			end
			return "(" .. concat1(out, " ") .. ")"
		elseif type_23_1(getmetatable1(value)) == "table" and type_23_1(getmetatable1(value)["--pretty-print"]) == "function" then
			return getmetatable1(value)["--pretty-print"](value)
		elseif tag == "list" then
			return value["contents"]
		elseif tag == "symbol" then
			return value["contents"]
		elseif tag == "key" then
			return ":" .. value["value"]
		elseif tag == "string" then
			return format1("%q", value["value"])
		elseif tag == "number" then
			return tostring1(value["value"])
		else
			local out = ({tag = "list", n = 0})
			local temp, v = next1(value)
			while temp ~= nil do
				out = cons1(pretty1(temp) .. " " .. pretty1(v), out)
				temp, v = next1(value, temp)
			end
			return "{" .. (concat1(out, " ") .. "}")
		end
	elseif ty == "string" then
		return format1("%q", value)
	else
		return tostring1(value)
	end
end)
display1 = (function(x)
	if type_23_1(x) == "string" then
		return x
	elseif type_23_1(x) == "table" and x["tag"] == "string" then
		return x["value"]
	else
		return pretty1(x)
	end
end)
local start, finish = find1("hey there bud", "t%S+")
return print1("From " .. display1(start) .. " to " .. display1(finish))
