--The top level most basic prototype object that all other objects inherit
local obj = {}

--The generic creation code for all prototypes
function obj:create()
    newObj = {}

    --Set the new object's parent to the calling type
    setmetatable(newObj, {__index = self})    

    return newObj
end

obj.parent = nil

obj.type = "luaPrototype"

obj.typeName = "basePrototype"

return obj
