describe('Imports, Creates and updates engine', function()
    it('imports the engine table', function()
        local engine, _, _ = require 'adorbs' ()
        assert(engine ~= nil)
    end)


    it('has the right initial state', function()
        local engine, _, _ = require 'adorbs' ()

        assert.are.same(engine.state(), {
            entities = {},
            systems = {}
        })
    end)

    it('runs process once on empty engine', function()
        local engine, _, _ = require 'adorbs' ()
        local fakeDelta = 0.016
        engine.process(fakeDelta)
    end)
end)
