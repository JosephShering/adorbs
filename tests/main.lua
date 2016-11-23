local engine, system, entity, component = require 'src/adorbs' ()
local inspect = require 'lib/inspect'

local state = {}
engine.create(state)
component.create("Transform", { x = 0, y = 0 })
component.create("Name", { displayName = "" })

entity.create("Player", {
    ["Transform"] = { x = 100, y = 100 },
    ["Name"] = { displayName = "Joe" }
})

entity.create("Node")
system.create(
    "InputControl",
    {"Character", "Transform"},
    function(components, dt)
        for _, component in pairs(components) do

        end
    end,
    function()

    end
)

engine.addSystem("InputControl")

print(inspect(state))
