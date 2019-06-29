extends Control
class_name BlendedTextureRect
tool

const uv_array = [Vector2(0.0, 0.0), Vector2(0.0, 1.0), Vector2(1.0, 1.0), Vector2(1.0, 0.0)]

var points = PoolVector2Array()
var colors = PoolColorArray()
var uvs = PoolVector2Array()

var points_should_update = true
var color_should_update = true
var uv_should_update = true

var ignore_resize = false

enum {ROTATION_0, ROTATION_90, ROTATION_180, ROTATION_270}

export(int, "0", "90", "180", "270") var fixed_rotation = ROTATION_0 setget set_fixed_rotation
export(Texture) var texture = Object() setget set_texture

func set_fixed_rotation(p_rotation):
	fixed_rotation = p_rotation
	update_uvs()
	
func set_texture(p_texture):
	if(p_texture):
		texture = p_texture
	else:
		texture = Object()

func _init():
	update()
	
func _notification(what):
	if(what == NOTIFICATION_RESIZED):
		_on_resized()
	elif(what == NOTIFICATION_DRAW):
		if(points_should_update):
			update_points()
		if(color_should_update):
			update_colors()
		if(uv_should_update):
			update_uvs()
		
		draw_primitive(points, colors, uvs, texture)
	
func update_points():
	points = PoolVector2Array()
	
	points.push_back(Vector2(0.0, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))
	
	points_should_update = false
	
func update_colors():
	colors = PoolColorArray()
	
	colors.push_back(Color())
	colors.push_back(Color())
	colors.push_back(Color())
	colors.push_back(Color())
	
	color_should_update = false
	
func update_uvs():
	uvs = PoolVector2Array()
	
	if(fixed_rotation == ROTATION_0):
		uvs.push_back(uv_array[0])
		uvs.push_back(uv_array[1])
		uvs.push_back(uv_array[2])
		uvs.push_back(uv_array[3])
	elif(fixed_rotation == ROTATION_90):
		uvs.push_back(uv_array[1])
		uvs.push_back(uv_array[2])
		uvs.push_back(uv_array[3])
		uvs.push_back(uv_array[0])
	elif(fixed_rotation == ROTATION_180):
		uvs.push_back(uv_array[2])
		uvs.push_back(uv_array[3])
		uvs.push_back(uv_array[0])
		uvs.push_back(uv_array[1])
	elif(fixed_rotation == ROTATION_270):
		uvs.push_back(uv_array[3])
		uvs.push_back(uv_array[0])
		uvs.push_back(uv_array[1])
		uvs.push_back(uv_array[2])
	
	uv_should_update = false

func _on_resized():
	if(ignore_resize == false):
		points_should_update = true
		update()
