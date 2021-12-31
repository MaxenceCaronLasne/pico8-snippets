#include "objects.lua"

Timers = {
	enabled = true,
	last = time(), --timestamp of the last update
	reg = {},
}

Objects:register_updatee(Timers)
function Timers:update()
	local now = time()
	local delta = now - self.last
	self.last = now

	for timer in all(self.reg) do
		self:_update_single_timer(timer, delta)
	end
end

function Timers:register_timer(seconds, callback, is_looping)
  -- Register a timer, an object that will call a function
  -- after some time.
  --
  -- seconds: time before `callback` is called
  -- callback: function to call after `seconds`
  -- is_looping: if true, `callback` is called indefinitly
  --             each `seconds`
  local timer = {
    max = seconds,
    remaining = seconds,
    callback = callback,
    is_looping = is_looping,
  }

  add(self.reg, timer)
end

-- private

function Timers:_update_single_timer(timer, delta)
  timer.remaining = max(0, timer.remaining - delta)

  if timer.remaining > 0 then
    return
  end

  timer.callback()

  if not timer.is_looping then
    del(self.reg, timer)
    return
  end

  timer.remaining = timer.max
end
