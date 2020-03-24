extends Node2D

export (Texture) var track_amp : Texture

export (Texture) var sky_texture : Texture

export (Texture) var player_texture : Texture

var sc : float = 0
var y = 0
var y_sc = 0

var count = 0

var tex_scroll = 0

var world_pos = Vector2(0, 0)

func _draw():
	draw_texture_rect(sky_texture, Rect2(-512 + tex_scroll, 0, 512, 128), false)
	draw_texture_rect(sky_texture, Rect2(0 + tex_scroll, 0, 512, 128), false)
	
	draw_texture_rect(sky_texture, Rect2(-1023 + tex_scroll, 0, 512, 128), false)
	draw_texture_rect(sky_texture, Rect2(512 + tex_scroll, 0, 512, 128), false)
	count = 0
	sc = 1
	y_sc = 1
	for i in 598:
		var scanline = Rect2(-256 + -y_sc, 128+count+y_sc, 512 + (y_sc*2), y_sc)
		draw_set_transform(Vector2(256, 0), 0, Vector2(1, 1))
		draw_texture_rect_region(track_amp, scanline, Rect2(world_pos.x, i + world_pos.y, 256, 1))
		sc += 0
		y_sc *= 1.01
	draw_set_transform(Vector2(0, 0), 0, Vector2(1, 1))
	draw_texture_rect(player_texture, Rect2(256-16, 350-16, 48, 48), false)

func _process(delta):
	visible = true
	update()
	if Input.is_key_pressed(KEY_LEFT):
		tex_scroll -= -2
		world_pos.x += -1
	if Input.is_key_pressed(KEY_RIGHT):
		world_pos.x -= -1
		tex_scroll += -2
	if Input.is_key_pressed(KEY_UP):
		world_pos.y -= 1
	if Input.is_key_pressed(KEY_DOWN):
		world_pos.y += 1
	if tex_scroll > 512 or -512 > tex_scroll:
		tex_scroll = 0