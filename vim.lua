if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _2f_1, _25_1, _2e2e_1, arg_23_1, len_23_1, error1, getmetatable1, next1, print1, getIdx1, setIdx_21_1, setmetatable1, tonumber1, tostring1, type_23_1, n1, slice1, find1, format1, lower1, match1, rep1, sub1, upper1, concat1, unpack1, list1, arg1, constVal1, apply1, first1, empty_3f_1, string_3f_1, number_3f_1, type1, neq_3f_1, map1, keys1, put_21_1, eq_3f_1, pretty1, floor1, max1, min1, car1, cdr1, map2, partition1, nth1, nths1, pushCdr_21_1, append1, range1, reverse1, cadr1, split1, createLookup1, exit1, getenv1, invokable_3f_1, compose1, lens1, getter_3f_1, setter_3f_1, composeInner1, _3c3e_1, _5e2e_1, _5e7e_1, on1, on_21_1, succ1, exit_21_1, self1, config1, coloredAnsi1, colored_3f_1, colored1, create1, setAction1, addAction1, addArgument_21_1, addHelp_21_1, usageNarg_21_1, usage_21_1, helpArgs_21_1, help_21_1, matcher1, parse_21_1, setTextColor1, setCursorPos1, blit1, getSize1, genLv1, setPixel1, writeBuff1, drawBuff1, genBuffer1, screenBuffer1, pullEvent1, queueEvent1, colors1, genContainer1, genStream1, peek1, match2, eat1, eatWhile1, skipTo1, skipToEnd1, eol1, next2, backUp1, current1, keywords1, api1, escapable1, initState1, nextToken1, langApi1, genParser1, prevState1, parseLines1, parseLine1, initBuffer1, fillData1, genHandle1, openHand1, closeHand1, cleanHand1, readHand1, writeHand1, imanagerVars1, init1, update1, drawContainer1, drawBuffer1, vimVars1
_3d_1 = function(v1, v2) return v1 == v2 end
_2f3d_1 = function(v1, v2) return v1 ~= v2 end
_3c_1 = function(v1, v2) return v1 < v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_3e_1 = function(v1, v2) return v1 > v2 end
_3e3d_1 = function(v1, v2) return v1 >= v2 end
_2b_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
_2d_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t - _select(i, ...) end return t end
_2f_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t / _select(i, ...) end return t end
_25_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t % _select(i, ...) end return t end
_2e2e_1 = function(...) local n = _select('#', ...) local t = _select(n, ...) for i = n - 1, 1, -1 do t = _select(i, ...) .. t end return t end
arg_23_1 = arg or {...}
len_23_1 = function(v1) return #v1 end
error1 = error
getmetatable1 = getmetatable
next1 = next
print1 = print
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
setmetatable1 = setmetatable
tonumber1 = tonumber
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
find1 = string.find
format1 = string.format
lower1 = string.lower
match1 = string.match
rep1 = string.rep
sub1 = string.sub
upper1 = string.upper
concat1 = table.concat
unpack1 = table.unpack
list1 = (function(...)
	local xs = _pack(...) xs.tag = "list"
	return xs
end)
if nil == arg_23_1 then
	arg1 = ({tag = "list", n = 0})
else
	arg_23_1["tag"] = "list"
	if not arg_23_1["n"] then
		arg_23_1["n"] = #arg_23_1
	end
	arg1 = arg_23_1
end
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
apply1 = (function(f, ...)
	local _n = _select("#", ...) - 1
	local xss, xs
	if _n > 0 then
		xss = { tag="list", n=_n, _unpack(_pack(...), 1, _n)}
		xs = select(_n + 1, ...)
	else
		xss = { tag="list", n=0}
		xs = ...
	end
	local args = (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_temp = xss
		for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_temp = xs
		for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 0
		return _result
	end)()
	return f(unpack1(args, 1, n1(args)))
end)
first1 = (function(...)
	local rest = _pack(...) rest.tag = "list"
	return rest[1]
end)
empty_3f_1 = (function(x)
	local xt = type1(x)
	if xt == "list" then
		return x["n"] == 0
	elseif xt == "string" then
		return #x == 0
	else
		return false
	end
end)
string_3f_1 = (function(x)
	return type_23_1(x) == "string" or type_23_1(x) == "table" and x["tag"] == "string"
end)
number_3f_1 = (function(x)
	return type_23_1(x) == "number" or type_23_1(x) == "table" and x["tag"] == "number"
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
floor1 = math.floor
max1 = math.max
min1 = math.min
car1 = (function(x)
	local temp = type1(x)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", temp), 2)
	end
	return x[1]
end)
cdr1 = (function(x)
	local temp = type1(x)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", temp), 2)
	end
	if empty_3f_1(x) then
		return ({tag = "list", n = 0})
	else
		return slice1(x, 2)
	end
end)
map2 = (function(fn, ...)
	local xss = _pack(...) xss.tag = "list"
	local ns
	local out = ({tag = "list", n = 0})
	local temp = n1(xss)
	local temp1 = 1
	while temp1 <= temp do
		if not (type1((nth1(xss, temp1))) == "list") then
			error1("not a list: " .. pretty1(nth1(xss, temp1)) .. " (it's a " .. type1(nth1(xss, temp1)) .. ")")
		end
		pushCdr_21_1(out, n1(nth1(xss, temp1)))
		temp1 = temp1 + 1
	end
	ns = out
	local out = ({tag = "list", n = 0})
	local temp = apply1(min1, ns)
	local temp1 = 1
	while temp1 <= temp do
		pushCdr_21_1(out, apply1(fn, nths1(xss, temp1)))
		temp1 = temp1 + 1
	end
	return out
end)
partition1 = (function(p, xs)
	local temp = type1(p)
	if temp ~= "function" then
		error1(format1("bad argument %s (expected %s, got %s)", "p", "function", temp), 2)
	end
	local temp = type1(xs)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", temp), 2)
	end
	local passed, failed = ({tag = "list", n = 0}), ({tag = "list", n = 0})
	local temp = n1(xs)
	local temp1 = 1
	while temp1 <= temp do
		local x = nth1(xs, temp1)
		pushCdr_21_1((function()
			if p(x) then
				return passed
			else
				return failed
			end
		end)(), x)
		temp1 = temp1 + 1
	end
	return unpack1(list1(passed, failed), 1, 2)
end)
nth1 = (function(xs, idx)
	if idx >= 0 then
		return xs[idx]
	else
		return xs[xs["n"] + 1 + idx]
	end
end)
nths1 = (function(xss, idx)
	local out = ({tag = "list", n = 0})
	local temp = n1(xss)
	local temp1 = 1
	while temp1 <= temp do
		pushCdr_21_1(out, nth1(nth1(xss, temp1), idx))
		temp1 = temp1 + 1
	end
	return out
end)
pushCdr_21_1 = (function(xs, val)
	local temp = type1(xs)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", temp), 2)
	end
	local len = n1(xs) + 1
	xs["n"] = len
	xs[len] = val
	return xs
end)
append1 = (function(xs, ys)
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_temp = xs
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_temp = ys
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 0
	return _result
end)
range1 = (function(...)
	local args = _pack(...) args.tag = "list"
	local x
	local out = ({})
	if n1(args) % 2 == 1 then
		error1("Expected an even number of arguments to range", 2)
	end
	local temp = n1(args)
	local temp1 = 1
	while temp1 <= temp do
		out[args[temp1]] = args[temp1 + 1]
		temp1 = temp1 + 2
	end
	x = out
	local st, ed = x["from"] or 1, 1 + x["to"] or error1("Expected end index, got nothing")
	local inc = (x["by"] or 1 + st) - st
	local tst
	if st >= ed then
		tst = _3e_1
	else
		tst = _3c_1
	end
	local c, out = st, ({tag = "list", n = 0})
	while tst(c, ed) do
		pushCdr_21_1(out, c)
		c = c + inc
	end
	return out
end)
reverse1 = (function(xs)
	local out = ({tag = "list", n = 0})
	local temp = n1(xs)
	while temp >= 1 do
		pushCdr_21_1(out, nth1(xs, temp))
		temp = temp + -1
	end
	return out
end)
cadr1 = (function(xs)
	local temp = type1(xs)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", temp), 2)
	end
	return xs[2]
end)
split1 = (function(text, pattern, limit)
	local out, loop, start = ({tag = "list", n = 0}), true, 1
	while loop do
		local pos = list1(find1(text, pattern, start))
		local nstart, nend = car1(pos), cadr1(pos)
		if nstart == nil or limit and n1(out) >= limit then
			loop = false
			pushCdr_21_1(out, sub1(text, start, n1(text)))
			start = n1(text) + 1
		elseif nstart > #text then
			if start <= #text then
				pushCdr_21_1(out, sub1(text, start, #text))
			end
			loop = false
		elseif nend < nstart then
			pushCdr_21_1(out, sub1(text, start, nstart))
			start = nstart + 1
		else
			pushCdr_21_1(out, sub1(text, start, nstart - 1))
			start = nend + 1
		end
	end
	return out
end)
createLookup1 = (function(values)
	local res = ({})
	local temp = n1(values)
	local temp1 = 1
	while temp1 <= temp do
		res[nth1(values, temp1)] = temp1
		temp1 = temp1 + 1
	end
	return res
end)
exit1 = os.exit
getenv1 = os.getenv
invokable_3f_1 = (function(x)
	while true do
		local temp = type1(x) == "function"
		if temp then
			return temp
		else
			local temp1 = type_23_1(x) == "table"
			if temp1 then
				local temp2 = type_23_1((getmetatable1(x))) == "table"
				if temp2 then
					x = getmetatable1(x)["__call"]
				else
					return temp2
				end
			else
				return temp1
			end
		end
	end
end)
compose1 = (function(f, g)
	if invokable_3f_1(f) and invokable_3f_1(g) then
		return (function(x)
			return f(g(x))
		end)
	else
		return nil
	end
end)
lens1 = (function(view, over)
	return setmetatable1(({["tag"]="lens",["view"]=view,["over"]=over}), ({["__call"]=(function(t, x)
		return _5e2e_1(x, t)
	end)}))
end)
getter_3f_1 = (function(lens)
	return lens["tag"] == "lens" and type1((lens["view"])) == "function"
end)
setter_3f_1 = (function(lens)
	return lens["tag"] == "lens" and type1((lens["over"])) == "function"
end)
composeInner1 = (function(l1, l2)
	local view1, view2, over1, over2 = l1["view"], l2["view"], l1["over"], l2["over"]
	return lens1((function()
		if view1 and view2 then
			return compose1(view2, view1)
		else
			return nil
		end
	end)(), (function()
		if over1 and over2 then
			return (function(f, x)
				return over1((function(x1)
					return over2(f, x1)
				end), x)
			end)
		else
			return nil
		end
	end)())
end)
_3c3e_1 = (function(...)
	local lenses = _pack(...) lenses.tag = "list"
	local _7c3e_
	_7c3e_ = (function(x)
		if n1(x) == 1 then
			return car1(x)
		elseif n1(x) == 2 then
			return composeInner1(car1(x), cadr1(x))
		elseif n1(x) > 2 then
			return composeInner1(car1(x), _7c3e_(cdr1(x)))
		else
			_error("unmatched item")
		end
	end)
	return _7c3e_(reverse1(lenses))
end)
_5e2e_1 = (function(val, lens)
	if getter_3f_1(lens) then
		return lens["view"](val)
	else
		return error1(pretty1(lens) .. " is not a getter")
	end
end)
_5e7e_1 = (function(val, lens, f)
	if setter_3f_1(lens) then
		return lens["over"](f, val)
	else
		return error1(pretty1(lens) .. " is not a setter")
	end
end)
on1 = (function(k)
	return lens1((function(x)
		return x[k]
	end), (function(f, x)
		local out = ({})
		local temp, v = next1(x)
		while temp ~= nil do
			if k == temp then
				out[temp] = f(v)
			else
				out[temp] = v
			end
			temp, v = next1(x, temp)
		end
		return out
	end))
end)
on_21_1 = (function(k)
	return lens1((function(x)
		return x[k]
	end), (function(f, x)
		x[k] = f(x[k])
		return x
	end))
end)
succ1 = (function(x)
	return x + 1
end)
exit_21_1 = (function(reason, code)
	local code1
	if string_3f_1(reason) then
		code1 = code
	else
		code1 = reason
	end
	if exit1 then
		if string_3f_1(reason) then
			print1(reason)
		end
		return exit1(code1)
	elseif string_3f_1(reason) then
		return error1(reason, 0)
	else
		local x
		return error1(nil, 0)
	end
end)
self1 = (function(x, key, ...)
	local args = _pack(...) args.tag = "list"
	return x[key](x, unpack1(args, 1, n1(args)))
end)
config1 = package.config
coloredAnsi1 = (function(col, msg)
	return "\27[" .. col .. "m" .. msg .. "\27[0m"
end)
local termTy = lower1(getenv1 and getenv1("TERM") or "")
if termTy == "dumb" then
	colored_3f_1 = false
elseif find1(termTy, "xterm") then
	colored_3f_1 = true
elseif config1 and sub1(config1, 1, 1) == "/" then
	colored_3f_1 = true
elseif getenv1 and getenv1("ANSICON") ~= nil then
	colored_3f_1 = true
else
	colored_3f_1 = false
end
if colored_3f_1 then
	colored1 = coloredAnsi1
else
	colored1 = (function(col, msg)
		return msg
	end)
end
create1 = (function(description)
	return ({["desc"]=description,["flag-map"]=({}),["opt-map"]=({}),["cats"]=({tag = "list", n = 0}),["opt"]=({tag = "list", n = 0}),["pos"]=({tag = "list", n = 0})})
end)
setAction1 = (function(arg, data, value)
	data[arg["name"]] = value
	return nil
end)
addAction1 = (function(arg, data, value)
	local lst = data[arg["name"]]
	if not lst then
		lst = ({tag = "list", n = 0})
		data[arg["name"]] = lst
	end
	return pushCdr_21_1(lst, value)
end)
addArgument_21_1 = (function(spec, names, ...)
	local options = _pack(...) options.tag = "list"
	local temp = type1(names)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "names", "list", temp), 2)
	end
	if empty_3f_1(names) then
		error1("Names list is empty")
	end
	if not (n1(options) % 2 == 0) then
		error1("Options list should be a multiple of two")
	end
	local result = ({["names"]=names,["action"]=nil,["narg"]=0,["default"]=false,["help"]="",["value"]=true})
	local first = car1(names)
	if sub1(first, 1, 2) == "--" then
		pushCdr_21_1(spec["opt"], result)
		result["name"] = sub1(first, 3)
	elseif sub1(first, 1, 1) == "-" then
		pushCdr_21_1(spec["opt"], result)
		result["name"] = sub1(first, 2)
	else
		result["name"] = first
		result["narg"] = "*"
		result["default"] = ({tag = "list", n = 0})
		pushCdr_21_1(spec["pos"], result)
	end
	local temp = n1(names)
	local temp1 = 1
	while temp1 <= temp do
		local name = names[temp1]
		if sub1(name, 1, 2) == "--" then
			spec["opt-map"][sub1(name, 3)] = result
		elseif sub1(name, 1, 1) == "-" then
			spec["flag-map"][sub1(name, 2)] = result
		end
		temp1 = temp1 + 1
	end
	local temp = n1(options)
	local temp1 = 1
	while temp1 <= temp do
		result[nth1(options, temp1)] = (nth1(options, temp1 + 1))
		temp1 = temp1 + 2
	end
	if not result["var"] then
		result["var"] = upper1(result["name"])
	end
	if not result["action"] then
		result["action"] = (function()
			local temp
			if number_3f_1(result["narg"]) then
				temp = result["narg"] <= 1
			else
				temp = result["narg"] == "?"
			end
			if temp then
				return setAction1
			else
				return addAction1
			end
		end)()
	end
	return result
end)
addHelp_21_1 = (function(spec)
	return addArgument_21_1(spec, ({tag = "list", n = 2, "--help", "-h"}), "help", "Show this help message", "default", nil, "value", nil, "action", (function(arg, result, value)
		help_21_1(spec)
		return exit_21_1(0)
	end))
end)
usageNarg_21_1 = (function(buffer, arg)
	local temp = arg["narg"]
	if temp == "?" then
		return pushCdr_21_1(buffer, " [" .. arg["var"] .. "]")
	elseif temp == "*" then
		return pushCdr_21_1(buffer, " [" .. arg["var"] .. "...]")
	elseif temp == "+" then
		return pushCdr_21_1(buffer, " " .. arg["var"] .. " [" .. arg["var"] .. "...]")
	else
		local temp1 = 1
		while temp1 <= temp do
			pushCdr_21_1(buffer, " " .. arg["var"])
			temp1 = temp1 + 1
		end
		return nil
	end
end)
usage_21_1 = (function(spec, name)
	if not name then
		name = nth1(arg1, 0) or (arg1[-1] or "?")
	end
	local usage = list1("usage: ", name)
	local temp = spec["opt"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local arg = temp[temp2]
		pushCdr_21_1(usage, " [" .. car1(arg["names"]))
		usageNarg_21_1(usage, arg)
		pushCdr_21_1(usage, "]")
		temp2 = temp2 + 1
	end
	local temp = spec["pos"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		usageNarg_21_1(usage, (temp[temp2]))
		temp2 = temp2 + 1
	end
	return print1(concat1(usage))
end)
helpArgs_21_1 = (function(pos, opt, format)
	if (empty_3f_1(pos) and empty_3f_1(opt)) then
		return nil
	else
		print1()
		local temp = n1(pos)
		local temp1 = 1
		while temp1 <= temp do
			local arg = pos[temp1]
			print1(format1(format, arg["var"], arg["help"]))
			temp1 = temp1 + 1
		end
		local temp = n1(opt)
		local temp1 = 1
		while temp1 <= temp do
			local arg = opt[temp1]
			print1(format1(format, concat1(arg["names"], ", "), arg["help"]))
			temp1 = temp1 + 1
		end
		return nil
	end
end)
help_21_1 = (function(spec, name)
	if not name then
		name = nth1(arg1, 0) or (arg1[-1] or "?")
	end
	usage_21_1(spec, name)
	if spec["desc"] then
		print1()
		print1(spec["desc"])
	end
	local max = 0
	local temp = spec["pos"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local arg = temp[temp2]
		local len = n1(arg["var"])
		if len > max then
			max = len
		end
		temp2 = temp2 + 1
	end
	local temp = spec["opt"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local arg = temp[temp2]
		local len = n1(concat1(arg["names"], ", "))
		if len > max then
			max = len
		end
		temp2 = temp2 + 1
	end
	local fmt = " %-" .. tostring1(max + 1) .. "s %s"
	helpArgs_21_1(first1(partition1((function(x)
		return x["cat"] == nil
	end), (spec["pos"]))), first1(partition1((function(x)
		return x["cat"] == nil
	end), (spec["opt"]))), fmt)
	local temp = spec["cats"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local cat = temp[temp2]
		print1()
		print1(colored1("4", cat["name"]))
		local desc = cat["desc"]
		if desc then
			print1(desc)
		end
		helpArgs_21_1(first1(partition1((function(x)
			return x["cat"] == cat["id"]
		end), (spec["pos"]))), first1(partition1((function(x)
			return x["cat"] == cat["id"]
		end), (spec["opt"]))), fmt)
		temp2 = temp2 + 1
	end
	return nil
end)
matcher1 = (function(pattern)
	return (function(x)
		local res = list1(match1(x, pattern))
		if car1(res) == nil then
			return nil
		else
			return res
		end
	end)
end)
parse_21_1 = (function(spec, args)
	if not args then
		args = arg1
	end
	local result, pos, idx, len, usage_21_ = ({}), spec["pos"], 1, n1(args), (function(msg)
		usage_21_1(spec, (nth1(args, 0)))
		print1(msg)
		return exit_21_1(1)
	end)
	local readArgs = (function(key, arg)
		local temp = arg["narg"]
		if temp == "+" then
			idx = idx + 1
			local elem = nth1(args, idx)
			if elem == nil then
				local msg, name = "Expected " .. arg["var"] .. " after --" .. key .. ", got nothing", nth1(args, 0)
				usage_21_1(spec, name)
				print1(msg)
				exit_21_1(1)
			elseif not arg["all"] and find1(elem, "^%-") then
				local msg, name = "Expected " .. arg["var"] .. " after --" .. key .. ", got " .. nth1(args, idx), nth1(args, 0)
				usage_21_1(spec, name)
				print1(msg)
				exit_21_1(1)
			else
				arg["action"](arg, result, elem, usage_21_)
			end
			local running = true
			while running do
				idx = idx + 1
				local elem = nth1(args, idx)
				if elem == nil then
					running = false
				elseif not arg["all"] and find1(elem, "^%-") then
					running = false
				else
					arg["action"](arg, result, elem, usage_21_)
				end
			end
			return nil
		elseif temp == "*" then
			local running = true
			while running do
				idx = idx + 1
				local elem = nth1(args, idx)
				if elem == nil then
					running = false
				elseif not arg["all"] and find1(elem, "^%-") then
					running = false
				else
					arg["action"](arg, result, elem, usage_21_)
				end
			end
			return nil
		elseif temp == "?" then
			idx = idx + 1
			local elem = nth1(args, idx)
			if elem == nil or not arg["all"] and find1(elem, "^%-") then
				return arg["action"](arg, result, arg["value"])
			else
				idx = idx + 1
				return arg["action"](arg, result, elem, usage_21_)
			end
		elseif temp == 0 then
			idx = idx + 1
			local value = arg["value"]
			return arg["action"](arg, result, value, usage_21_)
		else
			local temp1 = 1
			while temp1 <= temp do
				idx = idx + 1
				local elem = nth1(args, idx)
				if elem == nil then
					local msg, name = "Expected " .. temp .. " args for " .. key .. ", got " .. temp1 - 1, nth1(args, 0)
					usage_21_1(spec, name)
					print1(msg)
					exit_21_1(1)
				elseif not arg["all"] and find1(elem, "^%-") then
					local msg, name = "Expected " .. temp .. " for " .. key .. ", got " .. temp1 - 1, nth1(args, 0)
					usage_21_1(spec, name)
					print1(msg)
					exit_21_1(1)
				else
					arg["action"](arg, result, elem, usage_21_)
				end
				temp1 = temp1 + 1
			end
			idx = idx + 1
			return nil
		end
	end)
	while idx <= len do
		local temp = nth1(args, idx)
		local temp1
		local temp2 = matcher1("^%-%-([^=]+)=(.+)$")(temp)
		temp1 = type1(temp2) == "list" and (n1(temp2) >= 2 and (n1(temp2) <= 2 and true))
		if temp1 then
			local key, val = nth1(matcher1("^%-%-([^=]+)=(.+)$")(temp), 1), nth1(matcher1("^%-%-([^=]+)=(.+)$")(temp), 2)
			local arg = spec["opt-map"][key]
			if arg == nil then
				local msg, name = "Unknown argument " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
				usage_21_1(spec, name)
				print1(msg)
				exit_21_1(1)
			elseif not arg["many"] and nil ~= result[arg["name"]] then
				local msg, name = "Too may values for " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
				usage_21_1(spec, name)
				print1(msg)
				exit_21_1(1)
			else
				local narg = arg["narg"]
				if number_3f_1(narg) and narg ~= 1 then
					local msg, name = "Expected " .. tostring1(narg) .. " values, got 1 in " .. nth1(args, idx), nth1(args, 0)
					usage_21_1(spec, name)
					print1(msg)
					exit_21_1(1)
				end
				arg["action"](arg, result, val, usage_21_)
			end
			idx = idx + 1
		else
			local temp1
			local temp2 = matcher1("^%-%-(.*)$")(temp)
			temp1 = type1(temp2) == "list" and (n1(temp2) >= 1 and (n1(temp2) <= 1 and true))
			if temp1 then
				local key = nth1(matcher1("^%-%-(.*)$")(temp), 1)
				local arg = spec["opt-map"][key]
				if arg == nil then
					local msg, name = "Unknown argument " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
					usage_21_1(spec, name)
					print1(msg)
					exit_21_1(1)
				elseif not arg["many"] and nil ~= result[arg["name"]] then
					local msg, name = "Too may values for " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
					usage_21_1(spec, name)
					print1(msg)
					exit_21_1(1)
				else
					readArgs(key, arg)
				end
			else
				local temp1
				local temp2 = matcher1("^%-(.+)$")(temp)
				temp1 = type1(temp2) == "list" and (n1(temp2) >= 1 and (n1(temp2) <= 1 and true))
				if temp1 then
					local flags, i = nth1(matcher1("^%-(.+)$")(temp), 1), 1
					local s = n1(flags)
					while i <= s do
						local key
						local x = i
						key = sub1(flags, x, x)
						local arg = spec["flag-map"][key]
						if arg == nil then
							local msg, name = "Unknown flag " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
							usage_21_1(spec, name)
							print1(msg)
							exit_21_1(1)
						elseif not arg["many"] and nil ~= result[arg["name"]] then
							local msg, name = "Too many occurances of " .. key .. " in " .. nth1(args, idx), nth1(args, 0)
							usage_21_1(spec, name)
							print1(msg)
							exit_21_1(1)
						else
							local narg = arg["narg"]
							if i == s then
								readArgs(key, arg)
							elseif narg == 0 then
								local value = arg["value"]
								arg["action"](arg, result, value, usage_21_)
							else
								local value = sub1(flags, i + 1)
								arg["action"](arg, result, value, usage_21_)
								i = s + 1
								idx = idx + 1
							end
						end
						i = i + 1
					end
				else
					local arg = car1(spec["pos"])
					if arg then
						arg["action"](arg, result, temp, usage_21_)
					else
						local msg, name = "Unknown argument " .. arg, nth1(args, 0)
						usage_21_1(spec, name)
						print1(msg)
						exit_21_1(1)
					end
					idx = idx + 1
				end
			end
		end
	end
	local temp = spec["opt"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local arg = temp[temp2]
		if result[arg["name"]] == nil then
			result[arg["name"]] = arg["default"]
		end
		temp2 = temp2 + 1
	end
	local temp = spec["pos"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local arg = temp[temp2]
		if result[arg["name"]] == nil then
			result[arg["name"]] = arg["default"]
		end
		temp2 = temp2 + 1
	end
	return result
end)
setTextColor1 = term.setTextColor
setCursorPos1 = term.setCursorPos
blit1 = term.blit
getSize1 = term.getSize
genLv1 = (function(val, size)
	local out = ({tag = "list", n = 0})
	if type1(val) == "list" then
		local temp = 1
		while temp <= size do
			pushCdr_21_1(out, append1(({tag = "list", n = 0}), val))
			temp = temp + 1
		end
	else
		local temp = 1
		while temp <= size do
			pushCdr_21_1(out, val)
			temp = temp + 1
		end
	end
	return out
end)
setPixel1 = (function(buff, x, y, d, b, f)
	if not (type_23_1(d) == "nil") then
		local val, lens = nth1(buff["cur-rep"], y), on_21_1(1)
		local new
		local temp = nth1(nth1(buff["cur-rep"], y), 1)
		new = sub1(temp, 1, x - 1) .. d .. sub1(temp, x + 1)
		_5e7e_1(val, lens, (function(x1)
			return new
		end))
	end
	if not (type_23_1(b) == "nil") then
		local val, lens = nth1(buff["cur-rep"], y), on_21_1(2)
		local new
		local temp = nth1(nth1(buff["cur-rep"], y), 2)
		new = sub1(temp, 1, x - 1) .. b .. sub1(temp, x + 1)
		_5e7e_1(val, lens, (function(x1)
			return new
		end))
	end
	if not (type_23_1(f) == "nil") then
		local val, lens = nth1(buff["cur-rep"], y), on_21_1(3)
		local new
		local temp = nth1(nth1(buff["cur-rep"], y), 3)
		new = sub1(temp, 1, x - 1) .. f .. sub1(temp, x + 1)
		_5e7e_1(val, lens, (function(x1)
			return new
		end))
	end
	return _5e7e_1(buff["old-rep"], on_21_1(y), (function(x1)
		return true
	end))
end)
writeBuff1 = (function(buff, x, y, ds, bs, fs)
	local x1, y1, temp = floor1(x), floor1(y), n1(ds)
	local temp1 = 1
	while temp1 <= temp do
		local d, b, f = sub1(ds, temp1, temp1), sub1(bs, temp1, temp1), sub1(fs, temp1, temp1)
		setPixel1(buff, x1 + temp1 + -1, y1, d, b, f)
		temp1 = temp1 + 1
	end
	return nil
end)
drawBuff1 = (function(buff)
	local temp = buff["height"]
	local temp1 = 1
	while temp1 <= temp do
		local crep, orep = nth1(buff["cur-rep"], temp1), nth1(buff["old-rep"], temp1)
		if orep then
			setCursorPos1(1, temp1)
			apply1(blit1, list1(nth1(crep, 1), nth1(crep, 3), nth1(crep, 2)))
			_5e7e_1(buff["old-rep"], on_21_1(temp1), (function(x)
				return false
			end))
		end
		temp1 = temp1 + 1
	end
	return nil
end)
genBuffer1 = (function(w, h)
	local temp = type1(w)
	if temp ~= "number" then
		error1(format1("bad argument %s (expected %s, got %s)", "w", "number", temp), 2)
	end
	local temp = type1(h)
	if temp ~= "number" then
		error1(format1("bad argument %s (expected %s, got %s)", "h", "number", temp), 2)
	end
	return ({["old-rep"]=genLv1(true, h),["cur-rep"]=genLv1(genLv1(rep1("7", w), 3), h),["width"]=w,["height"]=h})
end)
screenBuffer1 = genBuffer1(getSize1())
pullEvent1 = os.pullEvent
queueEvent1 = os.queueEvent
colors1 = ({["other"]="0",["keyword"]="5",["comment"]="8",["string"]="9",["number"]="a",["api"]="4"})
genContainer1 = (function(ori)
	return ({["content"]=({tag = "list", n = 0}),["orient"]=(function()
		if type_23_1(ori) == "nil" then
			return 1
		else
			return ori
		end
	end)()})
end)
genStream1 = (function(string)
	return ({["string"]=string,["start"]=1,["pos"]=1,["peek"]=peek1,["match"]=match2,["eat"]=eat1,["eat-while"]=eatWhile1,["skip-to"]=skipTo1,["skip-to-end"]=skipToEnd1,["eol"]=eol1,["next"]=next2,["back-up"]=backUp1,["current"]=current1})
end)
peek1 = (function(stream)
	local char = sub1(stream["string"], stream["pos"], stream["pos"])
	if char then
		return char
	else
		return nil
	end
end)
match2 = (function(stream, pattern)
	local start, _eend = find1(stream["string"], pattern, stream["pos"])
	if start == stream["pos"] then
		stream["pos"] = _eend + 1
		return true
	else
		return nil
	end
end)
eat1 = (function(stream, pattern)
	local char = sub1(stream["string"], stream["pos"], stream["pos"])
	if find1(char, pattern) then
		_5e7e_1(stream, on_21_1("pos"), succ1)
		return char
	else
		return nil
	end
end)
eatWhile1 = (function(stream, pattern)
	local st = stream["pos"]
	while self1(stream, "eat", pattern) do
	end
	return stream["pos"] > st
end)
skipTo1 = (function(stream, char)
	local start, _eend = find1(stream["string"], char, stream["pos"])
	if start and start >= stream["pos"] then
		stream["pos"] = _eend
		return true
	else
		return nil
	end
end)
skipToEnd1 = (function(stream)
	stream["pos"] = 1 + n1(stream["string"])
	return nil
end)
eol1 = (function(stream)
	return stream["pos"] > n1(stream["string"] or "")
end)
next2 = (function(stream)
	if stream["pos"] <= n1(stream["string"]) then
		_5e7e_1(stream, on_21_1("pos"), succ1)
		return sub1(stream["string"], stream["pos"] - 1, stream["pos"] - 1)
	else
		return nil
	end
end)
backUp1 = (function(stream, n)
	if stream["pos"] > 1 then
		_5e7e_1(stream, on_21_1("pos"), (function(temp)
			return temp - (n or 1)
		end))
		return true
	else
		return nil
	end
end)
current1 = (function(stream)
	return sub1(stream["string"], stream["start"], stream["pos"] - 1)
end)
keywords1 = createLookup1(({tag = "list", n = 21, "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}))
api1 = createLookup1(({tag = "list", n = 1, "print"}))
escapable1 = createLookup1(({tag = "list", n = 10, ({tag="key", value="a"}), ({tag="key", value="b"}), ({tag="key", value="f"}), ({tag="key", value="n"}), ({tag="key", value="r"}), ({tag="key", value="t"}), ({tag="key", value="v"}), "\\", "\"", "'"}))
initState1 = (function()
	return ({["c-token"]="root",["starter"]=""})
end)
nextToken1 = (function(stream, state)
	local temp = state["c-token"]
	if temp == "root" then
		local char = self1(stream, "next")
		if char == "-" and self1(stream, "eat", "%-") then
			if self1(stream, "match", "%[%[") then
				state["c-token"] = "multiline-comment"
				if self1(stream, "skip-to", "%]%]") then
					self1(stream, "next")
					state["c-token"] = "root"
				else
					self1(stream, "skip-to-end")
				end
				return "comment"
			else
				self1(stream, "skip-to-end")
				return "comment"
			end
		elseif char == "\"" or char == "'" then
			state["c-token"] = "string"
			state["starter"] = char
			return "string"
		elseif char == "." and self1(stream, "match", "%d+") then
			return "number"
		elseif char == "0" and self1(stream, "eat", "[xX]") then
			self1(stream, "eat-while", "%x")
			return "number"
		elseif find1(char, "%d") then
			self1(stream, "eat-while", "%d")
			self1(stream, "match", "\\.%d+")
			if find1(self1(stream, "peek") or "", "[%w_]") then
				return "other"
			else
				return "number"
			end
		elseif char == "[" and self1(stream, "eat", "%[") then
			state["c-token"] = "multiline-string"
			return "string"
		elseif find1(char, "[%w_]") then
			self1(stream, "eat-while", "[%w_]")
			local word = self1(stream, "current")
			if keywords1[word] then
				return "keyword"
			elseif api1[word] then
				return "api"
			else
				return "other"
			end
		else
			return "other"
		end
	elseif temp == "string" then
		local char = self1(stream, "next")
		if char == "\\" then
			local escaped = self1(stream, "peek")
			if escaped and escapable1[escaped] then
				self1(stream, "next")
				return "escape"
			else
				return "string"
			end
		elseif char == state["starter"] then
			state["starter"] = ""
			state["c-token"] = "root"
			return "string"
		elseif self1(stream, "eol") then
			state["c-token"] = "root"
			return nil
		else
			return "string"
		end
	elseif temp == "multiline-string" then
		local char = self1(stream, "next")
		if char == "\\" then
			local escaped = self1(stream, "peek")
			if escaped and escapable1[escaped] then
				self1(stream, "next")
				return "escape"
			else
				return "string"
			end
		elseif char == "]" and self1(stream, "eat", "%]") then
			state["c-token"] = "root"
			return "string"
		else
			return "string"
		end
	elseif temp == "multiline-comment" then
		if self1(stream, "next") == "]" and self1(stream, "eat", "%]") then
			state["c-token"] = "root"
			return "comment"
		else
			return "comment"
		end
	else
		return error1("Invalid parse state `" .. state["c-token"] .. "`")
	end
end)
langApi1 = ({["lua"]=({["init-state"]=initState1,["next-token"]=nextToken1})})
genParser1 = (function(lang)
	return ({["lang"]=lang,["lang-api"]=langApi1[lang],["cache"]=({}),["state"]=nil,["prev-state"]=prevState1,["parse-lines"]=parseLines1,["parse-line"]=parseLine1})
end)
prevState1 = (function(parser, lineIndex)
	local idx = apply1(max1, append1(first1(partition1((function(temp)
		return temp < lineIndex
	end), (map2(tonumber1, range1("from", 1, "to", 3))))), ({tag = "list", n = 1, 0})))
	if tonumber1(idx) > 0 then
		return parser["cache"][idx]
	else
		return nil
	end
end)
parseLines1 = (function(parser, lines, lineIndex)
	local result = ({tag = "list", n = 2, ({tag = "list", n = 0}), ({ tag="symbol", contents="false"})})
	parser["cache"] = map2((function(temp)
		return parser["cache"][temp]
	end), first1(partition1((function(temp)
		return temp <= lineIndex
	end), (range1("from", 1, "to", 3)))))
	local temp = n1(lines)
	local temp1 = 1
	while temp1 <= temp do
		local line = lines[temp1]
		parser["state"] = ({})
		local tempState = parser["cache"][lineIndex + temp1 + -2] or (self1(parser, "prev-state", lineIndex) or parser["lang-api"]["init-state"]())
		local temp2, v = next1(tempState)
		while temp2 ~= nil do
			parser["state"][temp2] = v
			temp2, v = next1(tempState, temp2)
		end
		local previousState = ({})
		if parser["cache"][lineIndex + temp1 + -1] then
			local temp2 = parser["cache"][lineIndex + temp1 + -1]
			local temp3, v = next1(temp2)
			while temp3 ~= nil do
				previousState[temp3] = v
				temp3, v = next1(temp2, temp3)
			end
		end
		pushCdr_21_1(nth1(result, 1), self1(parser, "parse-line", line, lineIndex + temp1 + -1))
		parser["cache"][lineIndex + temp1 + -1] = ({})
		local temp2 = parser["state"]
		local temp3, v = next1(temp2)
		while temp3 ~= nil do
			if temp1 == n1(lines) and previousState[temp3] ~= parser["state"][temp3] then
				result[2] = true
			end
			parser["cache"][lineIndex + temp1 + -1][temp3] = v
			temp3, v = next1(temp2, temp3)
		end
		temp1 = temp1 + 1
	end
	return result
end)
parseLine1 = (function(parser, line, lineIndex)
	local result, stream = ({tag = "list", n = 0}), genStream1(line)
	while not self1(stream, "eol") do
		pushCdr_21_1(result, (parser["lang-api"]["next-token"](stream, parser["state"])))
		pushCdr_21_1(result, self1(stream, "current"))
		stream["start"] = stream["pos"]
	end
	if n1(result) == 0 then
		return ({tag = "list", n = 2, "other", line})
	else
		return result
	end
end)
initBuffer1 = (function(fileHandle, meta)
	local meta1 = meta or ({})
	meta1["size"] = meta1["size"] or 1
	meta1["pos"] = 1
	meta1["got"] = 0
	local newBuff = ({["handle"]=fileHandle,["cdata"]=({tag = "list", n = 0}),["meta"]=meta1,["parser"]=genParser1("lua"),["parsed"]=({})})
	fillData1(newBuff)
	return newBuff
end)
fillData1 = (function(buffer)
	buffer["handle"]["open"](buffer["handle"])
	local temp = buffer["meta"]["pos"] + buffer["meta"]["size"] + -1
	local temp1 = buffer["meta"]["got"]
	while temp1 <= temp do
		pushCdr_21_1(buffer["cdata"], car1(buffer["handle"]["read"](buffer["handle"], 1)))
		temp1 = temp1 + 1
	end
	local parseOut = buffer["parser"]["parse-lines"](buffer["parser"], slice1(buffer["cdata"], (buffer["meta"]["pos"] - 1) + 1, nil), buffer["meta"]["pos"])
	local temp = nth1(parseOut, 1)
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local pline = temp[temp2]
		buffer["parsed"][buffer["meta"]["pos"] + temp2 + -1] = pline
		temp2 = temp2 + 1
	end
	return nil
end)
genHandle1 = (function()
	return ({["open"]=openHand1,["read"]=readHand1,["write"]=writeHand1,["close"]=closeHand1,["cleanup"]=cleanHand1,["data"]=({["text"]="-- Hello world\n\nlocal i = 2\nfunction hello()\n  print(\"Hello!\")\nend\n\n--[[cool\nmultiline\ncomment]]\n\nprint([[It works!\nAll of it!]])\n",["openmode"]=0,["ptr"]=0})})
end)
openHand1 = (function(handle, mode)
	handle["data"]["ptr"] = 0
	if mode == 2 then
		handle["data"]["text"] = ""
		return nil
	else
		return nil
	end
end)
closeHand1 = (function(handle)
	return nil
end)
cleanHand1 = (function(handle)
	return nil
end)
readHand1 = (function(handle, amount)
	local lines = split1(handle["data"]["text"], "\n", amount + handle["data"]["ptr"])
	local result
	local xs = slice1(lines, handle["data"]["ptr"] + 1, nil)
	result = slice1(xs, 1, min1(amount, n1(xs)))
	_5e7e_1(handle, _3c3e_1(on_21_1("ptr"), on1("data")), (function(temp)
		return temp + amount
	end))
	return result
end)
writeHand1 = (function(handle, data)
	if not (handle["data"]["openmode"] == 2) then
		error1("Handle not opened in write mode", 0)
	end
	handle["data"]["text"] = handle["data"]["text"] .. data
	return nil
end)
imanagerVars1 = ({})
init1 = (function()
	imanagerVars1["container"] = genContainer1(2)
	local container, element = imanagerVars1["container"], ({["pref-w"]=0,["pref-h"]=0,["buffer"]=(initBuffer1(genHandle1(), ({["size"]=screenBuffer1["height"]})))})
	pushCdr_21_1(container["content"], element)
	return queueEvent1("fakeNews")
end)
update1 = (function()
	pullEvent1()
	return drawContainer1(imanagerVars1["container"], ({tag = "list", n = 4, 1, 1, screenBuffer1["width"], screenBuffer1["height"]}))
end)
drawContainer1 = (function(cont, cpos)
	local pos = append1(({tag = "list", n = 0}), cpos)
	local dw, dh, temp = pos[3] / (function()
		if cont["orient"] == 1 then
			return n1(cont["content"])
		else
			return 1
		end
	end)(), pos[4] / (function()
		if cont["orient"] == 2 then
			return n1(cont["content"])
		else
			return 1
		end
	end)(), cont["content"]
	local temp1 = n1(temp)
	local temp2 = 1
	while temp2 <= temp1 do
		local child = temp[temp2]
		local childpos = append1(({tag = "list", n = 0}), pos)
		childpos[3] = dw
		childpos[4] = dh
		if child["orient"] then
			drawContainer1(child, childpos)
		else
			drawBuffer1(child, childpos)
		end
		if cont["orient"] == 1 then
			_5e7e_1(pos, on_21_1(1), (function(temp3)
				return temp3 + dw
			end))
		elseif cont["orient"] == 2 then
			_5e7e_1(pos, on_21_1(2), (function(temp3)
				return temp3 + dh
			end))
		else
			_error("unmatched item")
		end
		temp2 = temp2 + 1
	end
	return nil
end)
drawBuffer1 = (function(window, pos)
	setTextColor1(2)
	local temp = window["buffer"]["meta"]["pos"] + window["buffer"]["meta"]["size"]
	local temp1 = window["buffer"]["meta"]["pos"]
	while temp1 <= temp do
		local textP, xp = window["buffer"]["parsed"][temp1], ({tag = "list", n = 1, pos[1]})
		local temp2 = n1(textP)
		local temp3 = 1
		while temp3 <= temp2 do
			local part = nth1(textP, temp3 + 1)
			if type1(part) == "string" then
				if type_23_1((colors1[nth1(textP, temp3)])) == "nil" then
					print1(textP)
					local x
					error1(nil, 0)
				end
				writeBuff1(screenBuffer1, car1(xp), temp1 + pos[2] + -1, part, rep1("7", n1(part)), rep1((function()
					if type_23_1((colors1[nth1(textP, temp3)])) == "nil" then
						return "f"
					else
						return colors1[nth1(textP, temp3)]
					end
				end)(), n1(part)))
				xp[1] = car1(xp) + n1(part)
			end
			temp3 = temp3 + 2
		end
		temp1 = temp1 + 1
	end
	return nil
end)
vimVars1 = ({["state"]="normal",["running"]=true})
local spec = create1()
addHelp_21_1(spec)
addArgument_21_1(spec, ({tag = "list", n = 1, "files"}), "help", "The input files")
local args = parse_21_1(spec, arg1)
init1()
while vimVars1["running"] do
	update1()
	drawBuff1(screenBuffer1)
end
return nil
