local lume = require 'lib/lume'

local Adorbs = {}
local engine = {}
local state = {
    resources = {
        components = {},
        systems = {}
    }
}

function engine.create(stateLocation)
    state = stateLocation

    state.resources = {
        components = {},
        systems = {},
        entities = {}
    }

    state.entities = {}
end

function engine.addSystem(name, system)
    state.resources.systems[name] = system
end

function engine.removeSystem(name)

end


local component = {}
function component.create(name, defaultFieldValues)
    state.resources.components[name] = defaultFieldValues
end

local system = {}
function system.create(name, logic)

end

local entity = {}
function entity.create(name, components, isActive)
    local newEntity = {
        active = isActive,
        components = {}
    }

    for name, component in pairs(components) do
        if type(name) == "string" and type(component) == "table" then
            newEntity.components[name] = component
        else
            print(name)
            newEntity.components[component] = lume.clone(state.resources.components[component])
        end
    end

    state.entities[name] = newEntity
end

function entity.addComponent(entity, component)
end

return function()
    return engine, system, entity, component
end

-- return {
--     engine = engine,
--     system = system,
--     entity = entity,
--     component = component
-- }
