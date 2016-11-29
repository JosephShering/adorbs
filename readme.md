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
end

function love.draw()
    engine.process()
end
```

If you're looking to move past the pare minimum I generally lay my projects out like so:

```
folders
 -> components
 -> entities
 -> systems
```

I populate those folders with my a respective ECS lua module that return a function, here is an example.

##### Component
```lua
-- newTransform.lua
return function(x, y, scale, rotation)
    return { x = x, y = y, scale = scale, rotation = rotation}
end
```

##### Entity
```lua
return function(spriteSheetLoc, x, y, speed)
    entity.create('player', {
        characterController = newCharacterController(speed),
        transform = newTransform(x, y)
    })
end
```

##### System
```lua
return function()
    system.create(
        'animator',
        {'animation', 'transform'},
        function(dt, animation, transform)
            local currentAnimation = animation.animations[animation.current]

            if currentAnimation == nil then
                error('You called an animation (' .. animation.current .. ') that does exist!')
                return
            end

            currentAnimation:update(dt)
            currentAnimation:draw(animation.image, transform.x, transform.y)
        end
    )
end
```

Then in your main.lua or scene file you just `require` what you need and they get added to the state automatically.

```lua
-- overworld.lua

local scene = {}
require 'systems/map' ()
require 'systems/inputController' ()
require 'systems/animator' ()

function scene:enter()
    require 'entities/map' ('maps/test') --you can make the functions accept arguments
    require 'entities/player' ('assets/animplayers.png', 20, 20, 40) 
end

function scene:draw(dt)
    engine.process()
end

return scene
```
