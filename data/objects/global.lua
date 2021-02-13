--The top level most basic object that all other objects inherit
local obj = {}

--A string representation of this object's parent
obj.parent = nil

--What is this thing?
obj.type = "luaObject"

--Unique Typename for this class of objects
obj.typeName = "globalObject"

--Interfaces
obj.interfaces = {}

--Returns whether the calling object or any of it's parents or any of its interfaces or the parents and interfaces thereof are of a given type
--Deliver me from my enemies, oh, my god. Defend me from them that rise up against me.
--Deliver me from the workers of iniquity and save me from bloody men. The mighty are gathered against me. Awake to help me and behold:
function obj:isTypeOf(other)
    --In this case other can be a string type or another object that contains the field "type"
    other = other.typeName or other

    --TODO: add another argument to filter out checking parent's interfaces since all interfaces are copied down to each generation

    --print ("Comparing types: "..other.." and "..self.typeName)
    
    --If we are exactly equal then short out true
    if other == self.typeName then
        return true
    end

    --Its not our typeName but it might be an interface typeName that we have
    if self.interfaces then
        for inter, _ in pairs(self.interfaces) do
            --print ("Comparing Interfaces: "..other.." and "..inter)
            if other == inter then
                return true
            end
        end
    end
    
    --Its not us or our interfaces but we might have a parent or interface thereof that works
    --This search excludes globalObject
    if self.parent then
        return data.proto[self.parent]:isTypeOf(other)
    end

    --None of our interfaces or parents or parents interfaces matched so now we check if our interfaces have parents or interfaces of their own that could match
    if self.interfaces then
        for _, inter in pairs(self.interfaces) do
            if ctrl.getObject(inter):isTypeOf(other) == true then
                return true
            end
        end
    end

    --Not the same at all
    return false
end

return obj
