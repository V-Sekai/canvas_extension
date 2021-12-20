@tool
class_name BlendedColorRibbon extends Control


var points: PackedVector2Array = PackedVector2Array()
var colors: PackedColorArray = PackedColorArray()

var points_should_update: bool = true
var color_should_update: bool = true

var ignore_resize: bool = false

@export var top_left_color: Color = Color() :
	set = _set_top_left_color

@export var bottom_left_color: Color = Color() :
	set = _set_bottom_left_color

@export var bottom_right_color: Color = Color() :
	set = _set_bottom_right_color

@export var top_right_color: Color = Color() :
	set = _set_top_right_color



func _set_top_left_color(p_color: Color) -> void:
	top_left_color = p_color
	color_should_update = true
	update()


func _set_bottom_left_color(p_color: Color) -> void:
	bottom_left_color = p_color
	color_should_update = true
	update()


func _set_bottom_right_color(p_color: Color) -> void:
	bottom_right_color = p_color
	color_should_update = true
	update()


func _set_top_right_color(p_color: Color) -> void:
	top_right_color = p_color
	color_should_update = true
	update()


func _init():
	update()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_RESIZED:
			_on_resized()
		NOTIFICATION_DRAW:
			if points_should_update:
				update_points()
			if color_should_update:
				update_colors()

			draw_primitive(points, colors, PackedVector2Array(), Object())


func update_points() -> void:
	points = PackedVector2Array()

	points.push_back(Vector2(get_size().x * 0.5, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x * 0.5, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))

	points_should_update = false


func update_colors() -> void:
	colors = PackedColorArray()

	colors.push_back(
		Color(
			top_left_color.r,
			top_left_color.b,
			top_left_color.g,
			top_left_color.a * get_modulate().a
		)
	)
	colors.push_back(
		Color(
			bottom_left_color.r,
			bottom_left_color.b,
			bottom_left_color.g,
			bottom_left_color.a * get_modulate().a
		)
	)
	colors.push_back(
		Color(
			bottom_right_color.r,
			bottom_right_color.b,
			bottom_right_color.g,
			bottom_right_color.a * get_modulate().a
		)
	)
	colors.push_back(
		Color(
			top_right_color.r,
			top_right_color.b,
			top_right_color.g,
			top_right_color.a * get_modulate().a
		)
	)

	color_should_update = false


func _on_resized() -> void:
	if ! ignore_resize:
		points_should_update = true
		update()
