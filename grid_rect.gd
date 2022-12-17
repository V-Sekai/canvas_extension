# res://addons/canvas_extension/grid_rect.gd
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
class_name GridRect extends Control


@export var grid_color : Color = Color(1.0, 1.0, 1.0, 1.0) :
	set = set_grid_color,
	get = get_grid_color

@export var snap_step : Vector2 = Vector2(64.0, 64.0) :
	set = set_snap_step,
	get = get_snap_step



func set_grid_color(p_color):
	grid_color = p_color
	queue_redraw()


func get_grid_color():
	return grid_color


func set_snap_step(p_snap_step):
	snap_step = p_snap_step
	queue_redraw()


func get_snap_step():
	return snap_step


func _draw():
	var s = get_size()
	var cursor

	cursor = 0
	while 1:
		cursor += snap_step.x
		if cursor < get_size().x:
			draw_line(Vector2(cursor, 0.0), Vector2(cursor, get_size().y), grid_color)
		else:
			break
	cursor = 0
	while 1:
		cursor += snap_step.y
		if cursor < get_size().y:
			draw_line(Vector2(0.0, cursor), Vector2(get_size().x, cursor), grid_color)
		else:
			break
