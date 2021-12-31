Sprites = {
	reg = {}
}

register_updatee(Sprites)
function Sprites:update()
end

--- public

function Sprites:register_sprite(key, sprite)
	-- sprite =
	--   enabled = bool,
	--   is_composed = bool,
	--   pos = {x, y},
	--   size = {x, y},
	--   [sprite_id = int],
	--   [sprite_ids = {name, id}],
	--   [step = {x, y}],
	--   [blueprint = [names]],
	assert(sprite.enabled != nil, "invalid sprite")
	assert(sprite.is_composed != nil, "invalid sprite")
	assert(sprite.pos != nil, "invalid sprite")
	assert(sprite.size != nil, "invalid sprite")

	if not sprite.is_composed then
		assert(sprite.sprite_id != nil, "invalid sprite")
	else
		assert(sprite.sprite_ids != nil, "invalid sprite")
		assert(sprite.step != nil, "invalid sprite")
		assert(sprite.blueprint != nil, "invalid sprite")
	end

	self.reg[key] = sprite
end

function Sprites:enable(key)
	self.reg[key].enabled = true
end

function Sprites:disable(key)
	self.reg[key].enabled = false
end

function Sprites:move(key, pos_x, pos_y)
	self.reg[key].pos.x = pos_x
	self.reg[key].pos.y = pos_y
end

function Sprites:delete(key)
	self.reg[key] = nil
end

function Sprites:draw(key)
	local s = self.reg[key]

	if s.is_composed then
		self:_draw_composite_sprite(s)
	else
		self:_draw_simple_sprite(s)
	end
end

-- private

function Sprites:_draw_composite_sprite(sprite)
	if not sprite.enabled then
		return
	end

	local bi = 1

	for sy=0, sprite.step.y - 1 do
		for sx=0, sprite.step.x - 1 do
			local spr_id = sprite.sprite_ids[sprite.blueprint[bi]]
			local pos_x = sprite.pos.x + sx*8
			local pos_y = sprite.pos.y + sy*8

			spr(spr_id, pos_x, pos_y, sprite.size.x, sprite.size.y)
			bi += 1
		end
	end
end

function Sprites:_draw_simple_sprite(sprite)
	if not sprite.enabled then
		return
	end

	spr(sprite.sprite_id,
	sprite.pos.x, sprite.pos.y,
	sprite.size.x, sprite.size.y)
end
