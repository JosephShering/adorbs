# (Totes) Adorbs

Adorbs is a function entity framework for LÖVE. Based on gamedev's entity
methodology.


## Getting Started

```
local engine, system, entity, component = require 'src/adorbs' ()

local state = {}

engine.create(state)
component.create("Transform", {x = 0, y = 0})
component.create("Character", { health = 100 })
component.create("Body", { fixture = {}, body = {}, world = {}, scale = 1, angle = 0 })

entity.create("Player", {
    ["Transform"] = { x = 100, y = 100 },
    "Character"
})
```

`engine.create/1` attaches itself to any table and will populate that table with ECS data.


## Engine State

Peeking into the engine state you'll see the structure

```
{
    resources = {
        components = {},
        systems = {}
    }
}
```

Resources hold the available components and systems that your game has access to, this
gets populated by `component.create` and `system.create`

## Best practices

It it is HIGHLY recommended that you do not edit your ECS state directly. Instead, write
functions for your systems to modify your an entities components
