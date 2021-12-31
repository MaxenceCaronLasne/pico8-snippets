Objects = {
	initees = {},
	updatees = {},
	drawees = {},
}

-- Register an object to add it to the gameloop list

-- Register an initee object to add it to the list of objects to initialize
-- at `_init` time.
-- The registred object require an `init()` method.
function Objects:register_initee(initee)
	add(self.initees, initee)
end

-- Register an updatee object to add it to the list of objects to update in
-- the gameloop.
-- The registred object require an `update()` method and an `enabled`
-- boolean attribute.
function Objects:register_updatee(updatee)
	add(self.updatees, updatee)
end

-- Register a drawee object to add it to the list of objects to draw in
-- the gameloop.
-- The registred object require an `draw()` method and an `enabled`
-- boolean attribute.
function Objects:register_drawee(drawee)
	add(self.drawees, drawee)
end

-- Call this method in the `_init()` function.
function Objects:init()
	for i in all(self.initees) do
		i:init()
	end
end

-- Call this method in the `_update()` function.
function Objects:update()
	for u in all(self.updatees) do
		if u.enabled then
			u:update()
		end
	end
end

-- Call this method in the `_draw()` function.
function Objects:draw()
	for d in all(self.drawees) do
		if d.enabled then
			d:draw()
		end
	end
end
