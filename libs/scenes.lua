Scenes = {
	current = "main",
	scenes = { "main" = {} },
}

function Scenes:register_scene(scene)
	self.scenes[scene] = {}
end

function Scenes:register_initee(initee, scene)
	add(self.scenes[scene], initee)
end

function Scenes:init_scene(scene)
	for i in all(self.scenes[scene]) do
		i:init()
	end
end
