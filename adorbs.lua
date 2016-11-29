local engine = {}
local system = {}
local entity = {}

local state = {
    entities = {},
    systems = {}
}

-- System
function system.create(name, components, processFunc, status)
    state.systems[name] = {
        status = status ~= nil and status or 'running',
        components = components,
        process = processFunc
    }
end

function system.pause(name)
    state.systems[name].status = 'paused'
end
-- end System

-- Engine
function engine.state()
    return state
end

function engine.process()
    for _, system in pairs(state.systems) do
        for entityName, entity in pairs(state.entities) do
            local pluckedEntityComponents = {}
            for _, requiredSystemComponentName in ipairs(system.components) do
                if entity.components[requiredSystemComponentName] ~= nil then
                    pluckedEntityComponents[#pluckedEntityComponents +1] = entity.components[requiredSystemComponentName]
                end
            end

            if #pluckedEntityComponents > 0 and system.status == 'running' then
                system.process(love.timer.getDelta(), unpack(pluckedEntityComponents))
            end
        end
    end
end

-- Entity
function entity.create(name, components, isActive)
    local newEntity = {
        status = 'init',
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
