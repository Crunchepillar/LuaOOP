--Parent object
local obj = {}

obj.parent = "basePrototype"
obj.typeName = "parentObject"

obj.interfaces = {
    baseInterface = true
}

function obj.sayHello()
    print("Hello")
end

return obj
