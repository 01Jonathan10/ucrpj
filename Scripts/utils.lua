Utils = {}
Utils.__index = Utils

function Utils.mergeTables(FirstTable, SecondTable)
	for k,v in pairs(SecondTable) do FirstTable[k] = v end
end

function Utils.CleanCheckID(Id)
	return Id:gsub("[a-zA-Z]","")
end

function Utils:randomEmptySpace()
	local y = math.random(1,Map.Ymax)
	local x = math.random(1,Map.Xmax)
	
	while Map[y+1][x] ~="0" do
		y = math.random(1,Map.Ymax)
		x = math.random(1,Map.Xmax)
	end
	
	return x,y
end

function Utils.inheritsFrom( baseClass )
    local new_class = {}
    local class_mt = { __index = new_class }

    function new_class:create()
        local newinst = {}
        setmetatable( newinst, class_mt )
        return newinst
    end

    if baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    return new_class
end

function Utils.Opposite(direction)
	return ((direction + 1) % 4) + 1
end

function Utils.PrintTb(tb)
	for key, value in pairs(tb) do
		print (key.." : "..tostring(value))
	end
end

function Utils.IsImage(Img)
	return tostring(type(Img))=='userdata'
end

function Utils.table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
		elseif type(k) == "number" then
			result = result.."["..k.."]".."="
        end

        if type(v) == "table" then
            result = result..Utils.table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        elseif type(v) == "number" then
			result = result..v
		elseif type(v) == "userdata" then
			result = result.."\"Image\""
		else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    if result ~= "{" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

function string:split(separator, isRegex, nMax)
	local separator = separator or " "
	local isRegex = isRegex or false
	local nMax = nMax or -1

    local aRecord = {}

    if self:len() > 0 then
		local isPlain = not isRegex

		local nField, nStart = 1, 1
		local nFirst,nLast = self:find(separator, nStart, isPlain)
		while nFirst and nMax ~= 0 do
			aRecord[nField] = self:sub(nStart, nFirst-1)
			nField = nField+1
			nStart = nLast+1
			nFirst,nLast = self:find(separator, nStart, isPlain)
			nMax = nMax-1
        end
        aRecord[nField] = self:sub(nStart)
    end

   return aRecord
end

function Utils.ConcatTable(t1,t2)
	for i=1,#t2 do
		t1[#t1 + i] = t2[i]
	end
end
