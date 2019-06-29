extends Control
class_name GridRect
tool

export(Color) var grid_color = Color(1.0, 1.0, 1.0, 1.0) setget set_grid_color, get_grid_color
export(Vector2) var snap_step = Vector2(64.0, 64.0) setget set_snap_step, get_snap_step

func set_grid_color(p_color):
	grid_color = p_color
	update()
	
func get_grid_color():
	return grid_color
	
func set_snap_step(p_snap_step):
	snap_step = p_snap_step
	update()
	
func get_snap_step():
	return snap_step

func _draw():
		var s = get_size()
		var cursor
		
		cursor = 0
		while(1):
			cursor += snap_step.x
			if cursor < get_size().x:
				draw_line(Vector2(cursor, 0.0), Vector2(cursor, get_size().y), grid_color)
			else:
				break
		
		cursor = 0
		while(1):
			cursor += snap_step.y
			if cursor < get_size().y:
				draw_line(Vector2(0.0, cursor), Vector2(get_size().x, cursor), grid_color)
			else:
				break
