minetest.register_node("mesecons_noteblock:noteblock", {
	description = "Note Block",
	tiles = {"mesecons_noteblock.png"},
	groups = {handy=1,axey=1, material_wood=1},
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	paramtype="light",
	is_ground_content = false,
	after_place_node = function(pos)
		minetest.add_node(pos, {name="mesecons_noteblock:noteblock", param2=0})
	end,
	on_rightclick = function (pos, node) -- change sound when punched
		local param2 = node.param2+1
		if param2==12 then param2=0 end
		minetest.add_node(pos, {name = node.name, param2 = param2})
		mesecon.noteblock_play(pos, param2)
	end,
	sounds = mcl_sounds.node_sound_wood_defaults(),
	mesecons = {effector = { -- play sound when activated
		action_on = function (pos, node)
			mesecon.noteblock_play(pos, node.param2)
		end
	}},
	_mcl_blast_resistance = 4,
	_mcl_hardness = 0.8,
})

minetest.register_craft({
	output = '"mesecons_noteblock:noteblock" 1',
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "mesecons:redstone", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "mesecons_noteblock:noteblock",
	burntime = 15
})

mesecon.noteblock_play = function (pos, param2)
	local soundname
	if param2==8 then
		soundname="mesecons_noteblock_a"
	elseif param2==9 then
		soundname="mesecons_noteblock_asharp"
	elseif param2==10 then
		soundname="mesecons_noteblock_b"
	elseif param2==11 then
		soundname="mesecons_noteblock_c"
	elseif param2==0 then
		soundname="mesecons_noteblock_csharp"
	elseif param2==1 then
		soundname="mesecons_noteblock_d"
	elseif param2==2 then
		soundname="mesecons_noteblock_dsharp"
	elseif param2==3 then
		soundname="mesecons_noteblock_e"
	elseif param2==4 then
		soundname="mesecons_noteblock_f"
	elseif param2==5 then
		soundname="mesecons_noteblock_fsharp"
	elseif param2==6 then
		soundname="mesecons_noteblock_g"
	elseif param2==7 then
		soundname="mesecons_noteblock_gsharp"
	end
	local block_below_name = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
	if block_below_name == "mcl_core:glass" then
		soundname="mesecons_noteblock_hihat"
	end
	if block_below_name == "mcl_core:stone" then
		soundname="mesecons_noteblock_kick"
	end
	if block_below_name == "mcl_core:chest" then
		soundname="mesecons_noteblock_snare"
	end
	if block_below_name == "mcl_core:tree" then
		soundname="mesecons_noteblock_crash"
	end
	if block_below_name == "mcl_core:wood" then
		soundname="mesecons_noteblock_litecrash"
	end
	minetest.sound_play(soundname,
	{pos = pos, gain = 1.0, max_hear_distance = 32,})
end
