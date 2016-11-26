local engine = {}
local system = {}
local entity = {}

local state = {
    entities = {},
    systems = {}
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

            system.process(love.timer.getDelta(), unpack(pluckedEntityComponents))
        end
    end
end
-- end Engine


-- System
function system.create(components, processFunc)

    state.systems[#state.systems + 1] = {
        components = components,
        process = processFunc
    }
end
-- end System


-- Entity
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
-- end Entity

return function()
    return engine, system, entity
end
