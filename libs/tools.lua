function debug_draw_hitbox(pos, hit)
	if not DEBUGGING then
		return
	end

	local x1 = pos.x + hit.offx
	local y1 = pos.y + hit.offy
	local x2 = x1 + hit.width
	local y2 = y1 + hit.height
	rect(x1, y1, x2, y2, 12)
end

function are_hitboxes_colliding(
	pos_a, hit_a, pos_b, hit_b)
	local ax1 = pos_a.x + hit_a.offx
	local ay1 = pos_a.y + hit_a.offy
	local ax2 = ax1 + hit_a.width
	local ay2 = ay1 + hit_a.height

	local bx1 = pos_b.x + hit_b.offx
	local by1 = pos_b.y + hit_b.offy
	local bx2 = bx1 + hit_b.width
	local by2 = by1 + hit_b.height

	local c1 = ay1 <= by2
	local c2 = ay2 >= by1
	local c3 = ax1 <= bx2
	local c4 = ax2 >= bx1

	local res = c1 and c2 and c3 and c4
	return res
end

