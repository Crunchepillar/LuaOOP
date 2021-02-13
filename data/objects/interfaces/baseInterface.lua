--The most basic interface from which all other interfaces inherit their members
local obj = {}

function obj.test()
    print("Interface Test")
end

obj.parent = nil
obj.type = "luaInterface"
obj.typeName = "baseInterface"

return obj
