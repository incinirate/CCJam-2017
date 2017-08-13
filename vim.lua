if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _2f_1, _25_1, _2e2e_1, len_23_1, error1, getmetatable1, next1, print1, getIdx1, setIdx_21_1, setmetatable1, tostring1, type_23_1, n1, slice1, format1, rep1, sub1, concat1, unpack1, list1, cons1, pretty1, empty_3f_1, type1, min1, random1, car1, cdr1, cons2, map1, nub1, nth1, nths1, pushCdr_21_1, append1, range1, lens1, getter_3f_1, setter_3f_1, _5e2e_1, _5e7e_1, head1, on_21_1, call1, setCursorPos1, blit1, clear1, getSize1, write1, setBackgroundColor1, genLv1, setPixel1, drawBuff1, genBuffer1, screenBuffer1, pullEvent1, startTimer1, green1, draw1, left1, update1
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
len_23_1 = function(v1) return #v1 end
error1 = error
getmetatable1 = getmetatable
next1 = next
print1 = print
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
rep1 = string.rep
sub1 = string.sub
concat1 = table.concat
unpack1 = table.unpack
list1 = (function(...)
	local xs = _pack(...) xs.tag = "list"
	return xs
end)
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
empty_3f_1 = (function(x)
	local xt = type1(x)
	if xt == "list" then
		return n1(x) == 0
	elseif xt == "string" then
		return #x == 0
	else
		return false
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
min1 = math.min
random1 = math.random
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
cons2 = (function(...)
	local _n = _select("#", ...) - 1
	local xs, xss
	if _n > 0 then
		xs = { tag="list", n=_n, _unpack(_pack(...), 1, _n)}
		xss = select(_n + 1, ...)
	else
		xs = { tag="list", n=0}
		xss = ...
	end
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_temp = xs
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_temp = xss
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 0
	return _result
end)
map1 = (function(fn, ...)
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
	local temp = min1(unpack1(ns, 1, n1(ns)))
	local temp1 = 1
	while temp1 <= temp do
		pushCdr_21_1(out, (function(xs)
			return fn(unpack1(xs, 1, n1(xs)))
		end)(nths1(xss, temp1)))
		temp1 = temp1 + 1
	end
	return out
end)
nub1 = (function(xs)
	local hm, out = ({}), ({tag = "list", n = 0})
	local temp = n1(xs)
	local temp1 = 1
	while temp1 <= temp do
		local elm = xs[temp1]
		local szd = pretty1(elm)
		if type_23_1((hm[szd])) == "nil" then
			pushCdr_21_1(out, elm)
			hm[szd] = elm
		end
		temp1 = temp1 + 1
	end
	return out
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
head1 = lens1(car1, (function(f, x)
	return cons2(f(car1(x)), cdr1(x))
end))
on_21_1 = (function(k)
	return lens1((function(x)
		return x[k]
	end), (function(f, x)
		x[k] = f(x[k])
		return x
	end))
end)
call1 = (function(x, key, ...)
	local args = _pack(...) args.tag = "list"
	return x[key](unpack1(args, 1, n1(args)))
end)
setCursorPos1 = term.setCursorPos
blit1 = term.blit
clear1 = term.clear
getSize1 = term.getSize
write1 = term.write
setBackgroundColor1 = term.setBackgroundColor
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
drawBuff1 = (function(buff)
	local temp = buff["height"]
	local temp1 = 1
	while temp1 <= temp do
		local crep, orep = nth1(buff["cur-rep"], temp1), nth1(buff["old-rep"], temp1)
		if orep then
			setCursorPos1(1, temp1)
			local xs = list1(nth1(crep, 1), nth1(crep, 3), nth1(crep, 2))
			blit1(unpack1(xs, 1, n1(xs)))
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
	local newBuff = ({})
	local lens, new = on_21_1("old-rep"), genLv1(true, h)
	_5e7e_1(newBuff, lens, (function(x)
		return new
	end))
	local lens, new = on_21_1("cur-rep"), genLv1(genLv1(rep1("0", w), 3), h)
	_5e7e_1(newBuff, lens, (function(x)
		return new
	end))
	_5e7e_1(newBuff, on_21_1("width"), (function(x)
		return w
	end))
	_5e7e_1(newBuff, on_21_1("height"), (function(x)
		return h
	end))
	return newBuff
end)
screenBuffer1 = genBuffer1(getSize1())
print1("Buffer loaded!")
pullEvent1 = os.pullEvent
startTimer1 = os.startTimer
green1 = colors.green
draw1 = (function()
	setBackgroundColor1(green1)
	clear1()
	setCursorPos1(3, 3)
	write1("Hello Urn!")
	setCursorPos1(3, 5)
	return write1(pretty1(nub1(map1((function()
		return random1(0, 10)
	end), range1(1, 50)))))
end)
left1 = ({tag = "list", n = 1, "Hello world!"})
update1 = (function()
	pullEvent1()
	startTimer1(1 / 20)
	setPixel1(screenBuffer1, 16 - n1(nth1(left1, 1)), 4, sub1(nth1(left1, 1), 1, 1), "4", "f")
	local new = sub1(nth1(left1, 1), 2)
	return _5e7e_1(left1, head1, (function(x)
		return new
	end))
end)
local states = ({["normal"]=({["update"]=update1,["draw"]=draw1})})
local stateIdx = states["normal"]
while true do
	call1(stateIdx, "update")
	drawBuff1(screenBuffer1)
end
