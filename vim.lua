if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then return f, e end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _3d_1, _2f3d_1, _3c_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _25_1, _2e2e_1, arg_23_1, len_23_1, error1, getmetatable1, next1, print1, getIdx1, setIdx_21_1, setmetatable1, tostring1, type_23_1, n1, slice1, find1, format1, lower1, match1, rep1, sub1, upper1, concat1, unpack1, list1, cons1, pretty1, arg1, apply1, first1, empty_3f_1, string_3f_1, number_3f_1, type1, max1, car1, cdr1, partition1, nth1, pushCdr_21_1, append1, reverse1, cadr1, split1, keys1, createLookup1, exit1, getenv1, invokable_3f_1, compose1, lens1, getter_3f_1, setter_3f_1, composeInner1, _3c3e_1, _5e2e_1, _5e7e_1, on1, on_21_1, exit_21_1, self1, config1, coloredAnsi1, colored_3f_1, colored1, create1, setAction1, addAction1, addArgument_21_1, addHelp_21_1, usageNarg_21_1, usage_21_1, helpArgs_21_1, help_21_1, matcher1, parse_21_1, setCursorPos1, blit1, getSize1, genLv1, drawBuff1, genBuffer1, screenBuffer1, pullEvent1, queueEvent1, genContainer1, initBuffer1, genHandle1, openHand1, closeHand1, cleanHand1, readHand1, writeHand1, imanagerVars1, init1, update1, keywords1, api1, escapable1, initState1, nextToken1, langApi1, genParser1, prevState1, vimVars1
_3d_1 = function(v1, v2) return v1 == v2 end
_2f3d_1 = function(v1, v2) return v1 ~= v2 end
_3c_1 = function(v1, v2) return v1 < v2 end
_3c3d_1 = function(v1, v2) return v1 <= v2 end
_3e_1 = function(v1, v2) return v1 > v2 end
_3e3d_1 = function(v1, v2) return v1 >= v2 end
_2b_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t + _select(i, ...) end return t end
_2d_1 = function(...) local t = ... for i = 2, _select('#', ...) do t = t - _select(i, ...) end return t end
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
if nil == arg_23_1 then
	arg1 = ({tag = "list", n = 0})
else
	arg_23_1["tag"] = "list"
	if not arg_23_1["n"] then
		arg_23_1["n"] = #arg_23_1
	end
	arg1 = arg_23_1
end
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
max1 = math.max
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
keys1 = (function(st)
	local out = ({tag = "list", n = 0})
	local temp, _ = next1(st)
	while temp ~= nil do
		pushCdr_21_1(out, temp)
		temp, _ = next1(st, temp)
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
	local lines = split1(_5e2e_1(handle, _3c3e_1(on1("text"), on1("data"))), "[^\n]+", amount + _5e2e_1(handle, _3c3e_1(on1("ptr"), on1("data"))))
	slice1(lines, _5e2e_1(handle, _3c3e_1(on1("ptr"), on1("data"))) + 1, nil)
	_5e7e_1(handle, _3c3e_1(on_21_1("ptr"), on1("data")), (function(temp)
		return temp + amount
	end))
	return lines
end)
writeHand1 = (function(handle, data)
	if not (handle["data"]["openmode"] == 2) then
		error1("Handle not opened in write mode", 0)
	end
	return _5e7e_1(handle, _3c3e_1(on_21_1("text"), on1("data")), (function(temp)
		return temp .. data
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
keywords1 = createLookup1(({tag = "list", n = 21, ({tag="key", value="and"}), ({tag="key", value="break"}), ({tag="key", value="do"}), ({tag="key", value="else"}), ({tag="key", value="elseif"}), ({tag="key", value="end"}), ({tag="key", value="false"}), ({tag="key", value="for"}), ({tag="key", value="function"}), ({tag="key", value="if"}), ({tag="key", value="in"}), ({tag="key", value="local"}), ({tag="key", value="nil"}), ({tag="key", value="not"}), ({tag="key", value="or"}), ({tag="key", value="repeat"}), ({tag="key", value="return"}), ({tag="key", value="then"}), ({tag="key", value="true"}), ({tag="key", value="until"}), ({tag="key", value="while"})}))
api1 = createLookup1(({tag = "list", n = 1, ({tag="key", value="drawPixel"})}))
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
			return nil
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
	else
		return error1("Invalid parse state `" .. state["c-token"] .. "`")
	end
end)
langApi1 = ({["lua"]=({["init-state"]=initState1,["next-token"]=nextToken1})})
genParser1 = (function(lang)
	return ({["lang"]=lang,["cache"]=({}),["state"]=langApi1[_3c3e_1(on1("init-state"), on1(lang))],["prev-state"]=prevState1})
end)
prevState1 = (function(parser, lineIndex)
	local idx = apply1(max1, append1(first1(partition1((function(temp)
		return temp < lineIndex
	end), (keys1(parser["cache"])))), ({tag = "list", n = 1, 0})))
	if idx > 0 then
		return parser["cache"][idx]
	else
		return nil
	end
end)
genParser1()
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
