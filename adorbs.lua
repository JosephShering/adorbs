local engine = {}
local system = {}
local entity = {}

local state = {
    entities = {},
    systems = {},
    _componentToEntity = {}
}

-- Engine
function engine.state()
    return state
end

function engine.process()
    for systemName, system in pairs(state.systems) do
        for entityName, entity in pairs(state.entities) do

            local pluckedEntityComponents = {}

            for _, requiredSystemComponentName in ipairs(system.components) do
                if entity.components[requiredSystemComponentName] ~= nil then
                    pluckedEntityComponents[#pluckedEntityComponents +1] = entity.components[requiredSystemComponentName]
                end
            end
            system.update(love.timer.getDelta(), unpack(pluckedEntityComponents))
        end
    end
end
-- end Engine


-- System
function system.create(name, components, updateFunc, drawFunc)

    if state.systems[name] ~= nil then
        print("That system already exists")
    else
        state.systems[name] = {
            components = components,
            update = updateFunc,
            draw = drawFunc
        }
    end

end
-- end System


-- Entity
-- entity.create
-- Creates an entity and adds it to the state.entities
function entity.create(name, components, isActive)
    local newEntity = {
        active = isActive,
        components = {}
    }

    if components ~= nil then
        -- Allows the passing of either a string or another table
        for componentName, component in pairs(components) do
            if type(componentName) == "string" and type(component) == "table" then
                newEntity.components[componentName] = component
            else
                newEntity.components[component] = {}
            end
        end
    end

    state.entities[name] = newEntity
    return state.entities[name]
end

function entity.component(entityName, componentName)
    return state.entities[entityName].components[componentName]
end
-- end Entity

return function()
    return engine, system, entity
end
