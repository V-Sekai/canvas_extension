extends Control
tool

var points = PoolVector2Array()
var colors = PoolColorArray()

var points_should_update = true
var color_should_update = true

var ignore_resize = false

export(Color) var top_left_color = Color() setget _set_top_left_color
export(Color) var bottom_left_color = Color() setget _set_bottom_left_color
export(Color) var bottom_right_color = Color() setget _set_bottom_right_color
export(Color) var top_right_color = Color() setget _set_top_right_color


func _set_top_left_color(p_color):
	top_left_color = p_color
	color_should_update = true
	update()
	
func _set_bottom_left_color(p_color):
	bottom_left_color = p_color
	color_should_update = true
	update()
	
func _set_bottom_right_color(p_color):
	bottom_right_color = p_color
	color_should_update = true
	update()
	
func _set_top_right_color(p_color):
	top_right_color = p_color
	color_should_update = true
	update()

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
		
		draw_primitive(points, colors, PoolVector2Array(), Object())
	
func update_points():
	points = PoolVector2Array()
	
	points.push_back(Vector2(get_size().x * 0.5, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x * 0.5, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))
	
	points_should_update = false
	
func update_colors():
	colors = PoolColorArray()
	
	colors.push_back(Color(top_left_color.r, top_left_color.b, top_left_color.g, top_left_color.a * get_opacity()))
	colors.push_back(Color(bottom_left_color.r, bottom_left_color.b, bottom_left_color.g, bottom_left_color.a * get_opacity()))
	colors.push_back(Color(bottom_right_color.r, bottom_right_color.b, bottom_right_color.g, bottom_right_color.a * get_opacity()))
	colors.push_back(Color(top_right_color.r, top_right_color.b, top_right_color.g, top_right_color.a * get_opacity()))
	
	color_should_update = false

func _on_resized():
	if(ignore_resize == false):
		points_should_update = true
		update()