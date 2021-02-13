--Protoype table loader
local control = {}

--Load the global basic object
control.globalObject = require("data.objects.global")

--Jank workaround to a problem
local function getObjectFrom(typeName, dataBase)
    if dataBase.proto[typeName] then
        return dataBase.proto[typeName]
    elseif dataBase.inter[typeName] then
        return dataBase.inter[typeName]
    end

    return nil
end

--Sets the parent and interfaces for the item
local function setParentAndInterfaces(item, dataBase)
    local parentObj
    local interObj

    --Short out if we've already been loaded before
    if item.loaded then
        --print("Skipping")
        return nil
    end

    --Inhertance here
    if item.parent then
         parentObj = getObjectFrom(item.parent, dataBase)
    else
        parentObj = control.globalObject
    end

    --print("Parent set to: "..parentObj.typeName)

    if parentObj then

        if parentObj.loaded then
            --Nothing
        else
            if parentObj.typeName ~= "globalObject" then
                setParentAndInterfaces(parentObj, dataBase)
            end
        end

        setmetatable(item, {__index = parentObj})

        else
            print("Unable to locate parent for "..item.typeName.." ( "..item.parent..")")
        end

    local rawInterfaces = rawget(item, "interfaces")
    
    --Merge our interfaces with our parent's interfaces
    if parentObj.interfaces then
        --Setup rawInterfaces if we didn't have any but our parent does
        rawInterfaces = rawInterfaces or {}
        for k, _ in pairs(parentObj.interfaces) do
            --merge each key
            rawInterfaces[k] = true
        end
    end

    --interfaces here
    if rawInterfaces then
        for inter, _ in pairs(rawInterfaces) do

            interObj = getObjectFrom(inter, dataBase)

            if interObj then
                --print("Linked interface for "..item.typeName.." ("..tostring(inter)..")")
                --Link the interface via metatable
                item[inter] = {}
                setmetatable(item[inter], {__index = interObj})
            else
                print("Unable to link interface for "..item.typeName.." ("..tostring(inter)..")")
                print("Interface Table:")
                for _, item in pairs(dataBase.inter) do
                    print(_..":"..item.typeName)
                end
            end
        end
    end

    item.loaded = true
    --print(item.typeName.." done loading")

end

--Load all the prototypes and interfaces
function control.loadAll()
    local dir = "data.objects.prototypes."
    local p = {}

    p.proto = {
        basePrototype = require(dir.."basePrototype"),
        parentObject = require(dir.."parent"),
        childObject = require(dir.."child")
    }

    dir = "data.objects.interfaces."
    p.inter = {
        baseInterface = require(dir.."baseInterface"),
        dummyInterface = require(dir.."dummyInterface")
    }

    --Post-load inhertance
    for _, item in pairs(p.proto) do
        setParentAndInterfaces(item, p)
    end
    for _, item in pairs(p.inter) do
        setParentAndInterfaces(item, p)
    end

    return p
end

function control.getObject(typeName)
    if data.proto[typeName] then
        return data.proto[typeName]
    end
    if data.inter[typeName] then
        return data.inter[typeName]
    end

    return nil
end

return control
