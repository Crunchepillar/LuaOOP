--Child object
local obj = {}

obj.parent = "parentObject"
obj.typeName = "childObject"
obj.interfaces = {
    dummyInterface = true
}

function obj.sayGoodbye()
    print("Cya")
end

return obj
