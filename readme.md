# (Totes) Adorbs

Adorbs is a functional entity framework for LÖVE. The goal was to provide a
minimal entity framework sdk with a centralized game state.


## Getting Started

Below is an example of a minimal ECS setup in adorbs.
```lua
local engine, system, entity, component = require 'adorbs' ()

function love.load()
    entity.create('player', {
        'characterController', -- components are defined inline, and can be empty, as long as they are a string
        'transform' = { x = 15, y = 0 }
    })

    system.create(
        {'characterController', 'transform'},
        function(delta, characterController, transform) -- called on each entity that matches components
            print(transform.x) -- should print out 15
        end
    )
end

function love.draw()
    engine.process()
end
```
