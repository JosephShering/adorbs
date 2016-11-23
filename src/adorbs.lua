local lume = require 'lib/lume'
local inspect = require 'lib/inspect'
local state = {}

-- Engine
local engine = {}
function engine.create(stateLocation)
    state = stateLocation

    state.resources = {
        components = {},
        systems = {}
    }

    state.entities = {}
    state.systems = {}
end

function engine.addSystem(systemName)
    local system, err = pcall(lume.clone, state.resources.systems[systemName])

    if err then
        print("No system called " .. systemName .. " in resources")
    else
        state.systems[systemName] = lume.clone(state.resources.systems[systemName])
    end
end

function engine.removeSystem(systemName)
    table.remove(state.systems[systemName])
end
-- end Engine


-- Component
local component = {}
function component.create(name, defaultFieldValues)
    state.resources.components[name] = defaultFieldValues
end
-- end Component


-- System
local system = {}
function system.create(name, components, updateFunc, drawFunc)
    state.resources.systems[name] = {
        update = updateFunc,
        draw = drawFunc
    }
end
-- end System


-- Entity
local entity = {}
function entity.create(name, components, isActive)
    local newEntity = {
        active = isActive,
        components = {}
    }

    if components ~= nil then
        for componentName, component in pairs(components) do
            if type(component) == 'table' and lume.count(component) <= 0 then
                print("You assigns the component " .. componentName .. " to " .. name .. " but it was empty")
            end

            if type(componentName) == "string" and type(component) == "table" then
                newEntity.components[componentName] = component
            else
                local resComp, error = pcall(lume.clone, state.resources.components[component])

                if error then
                    print('No component called ' .. component .. ' in resources')
                else
                    newEntity.components[component] = resComp
                end

            end
        end
    end

    state.entities[name] = newEntity
    return state.entities[name]
end

function entity.addComponent(entityName, componentName, componentOverride)
    state.entities[entityName].components[componentName] = lume.clone(state.resources.components[componentName])
end
-- end Entity


return function()
    return engine, system, entity, component
end
