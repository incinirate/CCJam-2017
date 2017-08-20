if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _2b_1, _2d_1, _2e2e_1, len_23_1, error1, getmetatable1, next1, getIdx1, setIdx_21_1, setmetatable1, tostring1, type_23_1, n1, slice1, format1, concat1, unpack1, list1, constVal1, type1, neq_3f_1, map1, keys1, put_21_1, eq_3f_1, pretty1
_3d_1 = function(v1, v2) return v1 == v2 end
_2f3d_1 = function(v1, v2) return v1 ~= v2 end
_3c_1 = function(v1, v2) return v1 < v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_2b_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
_2d_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t - _select(i, ...) end return t end
_2e2e_1 = function(...) local n = _select('#', ...) local t = _select(n, ...) for i = n - 1, 1, -1 do t = _select(i, ...) .. t end return t end
len_23_1 = function(v1) return #v1 end
error1 = error
getmetatable1 = getmetatable
next1 = next
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
setmetatable1 = setmetatable
tostring1 = tostring
type_23_1 = type
n1 = (function(x)
	if type_23_1(x) == "table" then
		return x["n"]
	else
		return #x
	end
end)
slice1 = (function(xs, start, finish)
	if not finish then
		finish = xs["n"]
		if not finish then
			finish = #xs
		end
	end
	local len = (finish - start) + 1
	if len < 0 then
		len = 0
	end
	local out, i, j = ({["tag"]="list",["n"]=len}), 1, start
	while j <= finish do
		out[i] = xs[j]
		i, j = i + 1, j + 1
	end
	return out
end)
format1 = string.format
concat1 = table.concat
unpack1 = table.unpack
list1 = (function(...)
	local xs = _pack(...) xs.tag = "list"
	return xs
end)
constVal1 = (function(val)
	if type_23_1(val) == "table" then
		local tag = val["tag"]
		if tag == "number" then
			return val["value"]
		elseif tag == "string" then
			return val["value"]
		else
			return val
		end
	else
		return val
	end
end)
type1 = (function(val)
	local ty = type_23_1(val)
	if ty == "table" then
		return val["tag"] or "table"
	else
		return ty
	end
end)
neq_3f_1 = (function(x, y)
	return not eq_3f_1(x, y)
end)
map1 = (function(f, x)
	local out = ({tag = "list", n = 0})
	local temp = n1(x)
	local temp1 = 1
	while temp1 <= temp do
		out[temp1] = f(x[temp1])
		temp1 = temp1 + 1
	end
	out["n"] = n1(x)
	return out
end)
keys1 = (function(x)
	local out, n = ({tag = "list", n = 0}), 0
	local temp, _ = next1(x)
	while temp ~= nil do
		n = 1 + n
		out[n] = temp
		temp, _ = next1(x, temp)
	end
	out["n"] = n
	return unpack1(out, 1, n(out))
end)
put_21_1 = (function(t, typs, l)
	while not (type1(typs) == "list" and n1(typs) == 1) do
		local x, y = typs[1], slice1(typs, 2)
		if t[x] then
			t, typs = t[x], y
		else
			t[x] = ({})
			t, typs = t[x], y
		end
	end
	t[typs[1]] = l
	return nil
end)
eq_3f_1 = setmetatable1(({["lookup"]=({})}), ({["__call"]=(function(temp_this, x, y)
	local temp_method
	local temp = temp_this["lookup"]
	if temp then
		local temp1 = temp[type1(x)]
		if temp1 then
			temp_method = temp1[type1(y)] or nil
		else
			temp_method = nil
		end
	else
		temp_method = nil
	end
	if not temp_method then
		if temp_this["default"] then
			temp_method = temp_this["default"]
		else
			error1("No matching method to call for " .. (type1(x) .. " ") .. (type1(y) .. " ") .. "\nthere are methods to call for " .. keys1(temp_this["lookup"]))
		end
	end
	return temp_method(x, y)
end)}))
put_21_1(eq_3f_1, list1("lookup", "list", "list"), (function(myself)
	myself = (function(x, y)
		if n1(x) ~= n1(y) then
			return false
		else
			local equal = true
			local temp = n1(x)
			local temp1 = 1
			while temp1 <= temp do
				if neq_3f_1(x[temp1], y[temp1]) then
					equal = false
				end
				temp1 = temp1 + 1
			end
			return equal
		end
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "table", "table"), (function(myself)
	myself = (function(x, y)
		local equal = true
		local temp, v = next1(x)
		while temp ~= nil do
			if neq_3f_1(v, y[temp]) then
				equal = false
			end
			temp, v = next1(x, temp)
		end
		return equal
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "symbol", "symbol"), (function(myself)
	myself = (function(x, y)
		return x["contents"] == y["contents"]
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "string", "symbol"), (function(myself)
	myself = (function(x, y)
		return x == y["contents"]
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "symbol", "string"), (function(myself)
	myself = (function(x, y)
		return x["contents"] == y
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "key", "string"), (function(myself)
	myself = (function(x, y)
		return x["value"] == y
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "string", "key"), (function(myself)
	myself = (function(x, y)
		return x == y["value"]
	end)
	return myself
end)(nil))
put_21_1(eq_3f_1, list1("lookup", "key", "key"), (function(myself)
	myself = (function(x, y)
		return x["value"] == y["value"]
	end)
	return myself
end)(nil))
eq_3f_1["default"] = (function(myself)
	myself = (function(x, y)
		return false
	end)
	return myself
end)(nil)
local original = getmetatable1(eq_3f_1)["__call"]
getmetatable1(eq_3f_1)["__call"] = (function(self, x, y)
	if x == y then
		return true
	else
		return original(self, x, y)
	end
end)
pretty1 = setmetatable1(({["lookup"]=({})}), ({["__call"]=(function(temp_this, x)
	local temp_method
	local temp = temp_this["lookup"]
	if temp then
		temp_method = temp[type1(x)] or nil
	else
		temp_method = nil
	end
	if not temp_method then
		if temp_this["default"] then
			temp_method = temp_this["default"]
		else
			error1("No matching method to call for " .. (type1(x) .. " ") .. "\nthere are methods to call for " .. keys1(temp_this["lookup"]))
		end
	end
	return temp_method(x)
end)}))
put_21_1(pretty1, list1("lookup", "list"), (function(myself)
	myself = (function(xs)
		return "(" .. concat1(map1(pretty1, xs), " ") .. ")"
	end)
	return myself
end)(nil))
put_21_1(pretty1, list1("lookup", "symbol"), (function(myself)
	myself = (function(x)
		return x["contents"]
	end)
	return myself
end)(nil))
put_21_1(pretty1, list1("lookup", "key"), (function(myself)
	myself = (function(x)
		return ":" .. x["value"]
	end)
	return myself
end)(nil))
put_21_1(pretty1, list1("lookup", "number"), (function(myself)
	myself = (function(x)
		return tostring1(constVal1(x))
	end)
	return myself
end)(nil))
put_21_1(pretty1, list1("lookup", "string"), (function(myself)
	myself = (function(x)
		return format1("%q", constVal1(x))
	end)
	return myself
end)(nil))
put_21_1(pretty1, list1("lookup", "table"), (function(myself)
	myself = (function(x)
		local out = ({tag = "list", n = 0})
		local temp, v = next1(x)
		while temp ~= nil do
			local _offset, _result, _temp = 0, {tag="list",n=0}
			_result[1 + _offset] = pretty1(temp) .. " " .. pretty1(v)
			_temp = out
			for _c = 1, _temp.n do _result[1 + _c + _offset] = _temp[_c] end
			_offset = _offset + _temp.n
			_result.n = _offset + 1
			out = _result
			temp, v = next1(x, temp)
		end
		return "{" .. (concat1(out, " ") .. "}")
	end)
	return myself
end)(nil))
pretty1["default"] = (function(myself)
	myself = (function(x)
		return tostring1(x)
	end)
	return myself
end)(nil)
return ({})
