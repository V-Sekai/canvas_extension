extends Control
class_name BlendedColorRect
tool

var points = PoolVector2Array()
var colors = PoolColorArray()

var points_should_update = true
var color_should_update = true

var ignore_resize = false

export (Color) var top_left_color = Color() setget _set_top_left_color
export (Color) var bottom_left_color = Color() setget _set_bottom_left_color
export (Color) var bottom_right_color = Color() setget _set_bottom_right_color
export (Color) var top_right_color = Color() setget _set_top_right_color


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
	match what:
		NOTIFICATION_RESIZED:
			_on_resized()
		NOTIFICATION_DRAW:
			if points_should_update:
				update_points()
			if color_should_update:
				update_colors()

			draw_primitive(points, colors, PoolVector2Array(), Object())


func update_points():
	points = PoolVector2Array()

	points.push_back(Vector2(0.0, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))

	points_should_update = false


func update_colors():
	colors = PoolColorArray()

	colors.push_back(top_left_color)
	colors.push_back(bottom_left_color)
	colors.push_back(bottom_right_color)
	colors.push_back(top_right_color)

	color_should_update = false


func _on_resized():
	if ! ignore_resize:
		points_should_update = true
		update()
