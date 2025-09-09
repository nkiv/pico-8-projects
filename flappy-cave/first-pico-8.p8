pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	gmaeover = false
	make_player()
	make_cave()
end

function _draw()
	cls()
	draw_player()
	draw_cave()
	
	if(gameover)then
		print("game over!", 44,44, 7)
		print("your score: "..player.score,34,54,7)
		print("press ❎ to play again!" ,18,72,6)
	else
		print("score:"..player.score,2,2,7)
	end
end

function _update()
	if(not gameover) then
		move_player()
		update_cave()
		check_hit()
	else
		if(btnp(5)) then _init() end --restart
	end
end
-->8
function make_player()
	player={}
	player.x = 24
	player.y = 60
	player.dy = 0
	player.rise = 1
	player.fall = 2
	player.dead = 3
	player.speed = 2
	player.score = 0
end

function draw_player()
	if(game_over) then
		spr(player.dead,player.x,player.y)
	elseif(player.dy < 0) then
		spr(player.rise,player.x,player.y)
	else
		spr(player.fall,player.x,player.y)
	end
end

function move_player()
 gravity = 0.2
 player.dy += gravity
 
 --jump
 if(btnp(2)) then
		player.dy -= 5
		sfx(0)
	end
	
	player.y += player.dy
	player.score += player.speed
end

function check_hit()
	for i=player.x,player.x+7 do
		if(cave[i+1].top > player.y or cave[i+1].btm< player.y+7) then
			gameover=true
			sfx(1)
		end
	end
end
-->8
function make_cave()
	cave={{["top"]=5,["btm"]=119}}
	top=45
	btm=85
end

function update_cave()
	if(#cave > player.speed) then
		for i=1,player.speed do
			del(cave, cave[i])
		end
	end
	
	while(#cave < 128) do
		local col={}
		local up=flr(rnd(7)-3)
		local down=flr(rnd(7)-3)
		col.top=mid(3,cave[#cave].top+up,top)
		col.btm=mid(btm,cave[#cave].btm+down,124)
		add(cave,col)
	end	
end

function draw_cave()
	top_color = 5
	btm_color = 5
	for i=1, #cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm,btm_color)
	end
end
__gfx__
0000000000aaaa0000aaaa0000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaa700aaaaa70099999a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aa0aa0aaaaaaaaaa99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaaaa0aa0aa99699699000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aa0000aaaaaaaaaa99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aa00aaa9aa00aaa89666699000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaaa009a00aa008999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aaa00009aaa0000899900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000d05010050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d05000000210500000011050000000804008030080300803008020080200802008010080100801000000000000000000000000000000000000000000000000000000000000000000000000000000000
