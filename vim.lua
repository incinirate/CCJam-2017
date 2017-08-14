if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _2e2e_1, len_23_1, error1, getmetatable1, next1, print1, getIdx1, setIdx_21_1, setmetatable1, tostring1, type_23_1, n1, slice1, find1, format1, rep1, sub1, concat1, unpack1, list1, cons1, pretty1, apply1, type1, car1, nth1, pushCdr_21_1, append1, cadr1, split1, lens1, getter_3f_1, setter_3f_1, _5e2e_1, _5e7e_1, on1, on_21_1, setCursorPos1, blit1, getSize1, genLv1, drawBuff1, genBuffer1, screenBuffer1, pullEvent1, queueEvent1, genContainer1, initBuffer1, genHandle1, openHand1, closeHand1, cleanHand1, readHand1, writeHand1, imanagerVars1, init1, update1, vimVars1
_3d_1 = function(v1, v2) return v1 == v2 end
_2f3d_1 = function(v1, v2) return v1 ~= v2 end
_3c_1 = function(v1, v2) return v1 < v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_3e_1 = function(v1, v2) return v1 > v2 end
_3e3d_1 = function(v1, v2) return v1 >= v2 end
_2b_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
_2d_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t - _select(i, ...) end return t end
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
find1 = string.find
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
type1 = (function(val)
	local ty = type_23_1(val)
	if ty == "table" then
		return val["tag"] or "table"
	else
		return ty
	end
end)
car1 = (function(x)
	local temp = type1(x)
	if temp ~= "list" then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", temp), 2)
	end
	return x[1]
end)
nth1 = (function(xs, idx)
	if idx >= 0 then
		return xs[idx]
	else
		return xs[xs["n"] + 1 + idx]
	end
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
	return ({["old-rep"]=genLv1(true, h),["cur-rep"]=genLv1(genLv1(rep1("0", w), 3), h),["width"]=w,["height"]=h})
end)
screenBuffer1 = genBuffer1(getSize1())
print1("Buffer loaded!")
pullEvent1 = os.pullEvent
queueEvent1 = os.queueEvent
genContainer1 = (function(ori)
	return ({["content"]=({tag = "list", n = 0}),["orient"]=(function()
		if type_23_1(ori) == "nil" then
			return 1
		else
			return ori
		end
	end)()})
end)
initBuffer1 = (function(fileHandle, meta)
	local meta1
	if type_23_1(meta) == "nil" then
		meta1 = ({})
	else
		meta1 = meta
	end
	local lens = on_21_1("size")
	local new
	if type_23_1((meta1["size"])) == "nil" then
		new = 1
	else
		new = meta1["size"]
	end
	_5e7e_1(meta1, lens, (function(x)
		return new
	end))
	_5e7e_1(meta1, on_21_1("pos"), (function(x)
		return 0
	end))
	_5e7e_1(meta1, on_21_1("got"), (function(x)
		return 0
	end))
	local buffer = (({["handle"]=fileHandle,["cdata"]="",["meta"]=meta1}))
	return nil
end)
genHandle1 = (function()
	return ({["open"]=openHand1,["read"]=readHand1,["write"]=writeHand1,["close"]=closeHand1,["cleanup"]=cleanHand1,["data"]=({["text"]="",["openmode"]=0,["ptr"]=0})})
end)
openHand1 = (function(handle, mode)
	return nil
end)
closeHand1 = (function(handle)
	return nil
end)
cleanHand1 = (function(handle)
	return nil
end)
readHand1 = (function(handle, amount)
	local lines = split1(_5e2e_1(handle["data"], on1("text")), "[^\n]+", amount + _5e2e_1(handle["data"], on1("ptr")))
	slice1(lines, _5e2e_1(handle["data"], on1("ptr")) + 1, nil)
	local val, lens, new = handle["data"], on_21_1("ptr"), amount + _5e2e_1(handle["data"], on1("ptr"))
	_5e7e_1(val, lens, (function(x)
		return new
	end))
	return lines
end)
writeHand1 = (function(handle, data)
	if not (handle["data"]["openmode"] == 2) then
		error1("Handle not opened in write mode", 0)
	end
	local lens, val = on_21_1("text"), handle["data"]
	local new = _2e2e_1(_5e2e_1(handle["data"], lens))
	return _5e7e_1(val, lens, (function(x)
		return new
	end))
end)
imanagerVars1 = ({})
init1 = (function()
	local lens, new = on_21_1("container"), genContainer1()
	_5e7e_1(imanagerVars1, lens, (function(x)
		return new
	end))
	local container, element = imanagerVars1["container"], ({["pref-w"]=0,["pref-h"]=0,["buffer"]=(initBuffer1(genHandle1()))})
	pushCdr_21_1(container["content"], element)
	return queueEvent1("fakeNews")
end)
update1 = (function()
	pullEvent1()
	local cont = imanagerVars1["container"]
	return nil
end)
vimVars1 = ({["state"]="normal",["running"]=true})
init1()
while vimVars1["running"] do
	update1()
	drawBuff1(screenBuffer1)
end
return nil
