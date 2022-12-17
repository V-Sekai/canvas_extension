# res://addons/canvas_extension/blended_texture_rect.gd
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
class_name BlendedTextureRect extends Control

const uv_array = [Vector2(0.0, 0.0), Vector2(0.0, 1.0), Vector2(1.0, 1.0), Vector2(1.0, 0.0)]

var points = PackedVector2Array()
var colors = PackedColorArray()
var uvs = PackedVector2Array()

var points_should_update = true
var color_should_update = true
var uv_should_update = true

var ignore_resize = false

const ROTATION_0 = 0
const ROTATION_90 = 1
const ROTATION_180 = 2
const ROTATION_270 = 3

@export_enum("0", "90", "180", "270") var fixed_rotation: int = ROTATION_0:
	set = set_fixed_rotation

@export var texture: Texture2D = Object():
	set = set_texture


func set_fixed_rotation(p_rotation):
	fixed_rotation = p_rotation
	update_uvs()


func set_texture(p_texture):
	if p_texture:
		texture = p_texture
	else:
		texture = Object()


func _init():
	queue_redraw()


func _notification(what):
	match what:
		NOTIFICATION_RESIZED:
			_on_resized()
		NOTIFICATION_DRAW:
			if points_should_update:
				update_points()
			if color_should_update:
				update_colors()
			if uv_should_update:
				update_uvs()
			draw_primitive(points, colors, uvs, texture)


func update_points():
	points = PackedVector2Array()

	points.push_back(Vector2(0.0, 0.0))
	points.push_back(Vector2(0.0, get_size().y))
	points.push_back(Vector2(get_size().x, get_size().y))
	points.push_back(Vector2(get_size().x, 0.0))

	points_should_update = false


func update_colors():
	colors = PackedColorArray()

	colors.push_back(Color())
	colors.push_back(Color())
	colors.push_back(Color())
	colors.push_back(Color())

	color_should_update = false


func update_uvs():
	uvs = PackedVector2Array()

	match fixed_rotation:
		ROTATION_0:
			uvs.push_back(uv_array[0])
			uvs.push_back(uv_array[1])
			uvs.push_back(uv_array[2])
			uvs.push_back(uv_array[3])
		ROTATION_90:
			uvs.push_back(uv_array[1])
			uvs.push_back(uv_array[2])
			uvs.push_back(uv_array[3])
			uvs.push_back(uv_array[0])
		ROTATION_180:
			uvs.push_back(uv_array[2])
			uvs.push_back(uv_array[3])
			uvs.push_back(uv_array[0])
			uvs.push_back(uv_array[1])
		ROTATION_270:
			uvs.push_back(uv_array[3])
			uvs.push_back(uv_array[0])
			uvs.push_back(uv_array[1])
			uvs.push_back(uv_array[2])

	uv_should_update = false


func _on_resized():
	if !ignore_resize:
		points_should_update = true
		queue_redraw()
