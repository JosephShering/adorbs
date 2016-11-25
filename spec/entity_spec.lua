describe('entities', function()
    it('imports entity api', function()
        local _, _, entity = require 'adorbs' ()
        assert(entity ~= nil)
    end)

    it('creates entity with no components', function()
        local _, _, entity = require 'adorbs' ()
        local entity = entity.create('faker')

        assert(entity ~= nil)
        assert.are.same(entity.components, {})
    end)

    it('creates entity with blank components', function()
        local _, _, entity = require 'adorbs' ()

        local entity = entity.create('faker', {
            'transform'
        })

        assert.are.same(entity.components.transform, {})
    end)

    it('creates entity with populated components', function()
        local _, _, entity = require 'adorbs' ()

        local entity = entity.create('faker', {
            transform = { x = 0, y = 0 }
        })

        assert.are.same(entity.components.transform, { x = 0, y = 0 })
    end)
end)
