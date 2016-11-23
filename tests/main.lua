local adorbs = require 'src/adorbs'
local inspect = require 'lib/inspect'

local engine = adorbs.engine
local component = adorbs.component
local entity = adorbs.entity

local state = {}

engine.create(state)
component.create("Transform", {x = 0, y = 0})
component.create("Character", { health = 100 })
component.create("Body", { fixture = {}, body = {}, world = {}, scale = 1, angle = 0 })

entity.create("Player", {
    ["Transform"] = { x = 100, y = 100 },
    "Character"
})

state.entities["Player"].active = true
state.entities["Player"].components["Transform"].x = 10
