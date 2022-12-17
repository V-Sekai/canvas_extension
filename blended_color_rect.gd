# res://addons/canvas_extension/blended_color_rect.gd
# This file is part of the V-Sekai Game.
# https://github.com/V-Sekai/canvas_extension
#
# Copyright (c) 2018-2022 SaracenOne
# Copyright (c) 2019-2022 K. S. Ernest (iFire) Lee (fire)
# Copyright (c) 2020-2022 Lyuma
# Copyright (c) 2020-2022 MMMaellon
# Copyright (c) 2022 V-Sekai Contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

@tool
class_name BlendedColorRect extends Control


var points = PackedVector2Array()
var colors = PackedColorArray()

var points_should_update = true
var color_should_update = true

var ignore_resize = false

@export var top_left_color : Color = Color() :
	set = _set_top_left_color

@export var bottom_left_color : Color = Color() :
	set = _set_bottom_left_color

@export var bottom_right_color : Color = Color() :
	set = _set_bottom_right_color

@export var top_right_color : Color = Color() :
	set = _set_top_right_color



func _set_top_left_color(p_color):
	top_left_color = p_color
	color_should_update = true
	update_minimum_size()


func _set_bottom_left_color(p_color):
	bottom_left_color = p_color
	color_should_update = true
	update_minimum_size()


func _set_bottom_right_color(p_color):
	bottom_right_color = p_color
	color_should_update = true
	update_minimum_size()


func _set_top_right_color(p_color):
	top_right_color = p_color
	color_should_update = true
	update_minimum_size()


func _init():
	update_minimum_size()


func _notification(what):
	match what:
		NOTIFICATION_RESIZED:
			_on_resized()
		NOTIFICATION_DRAW:
			if points_should_update:
				update_points()
			if color_should_update:
				update_colors()

			draw_primitive(points, colors, PackedVector2Array(), Object())


func update_points():
	points = PackedVector2Array()

	points.push_back(Vector2(0.0, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))

	points_should_update = false


func update_colors():
	colors = PackedColorArray()

	colors.push_back(top_left_color)
	colors.push_back(bottom_left_color)
	colors.push_back(bottom_right_color)
	colors.push_back(top_right_color)

	color_should_update = false


func _on_resized():
	if ! ignore_resize:
		points_should_update = true
	update_minimum_size()
