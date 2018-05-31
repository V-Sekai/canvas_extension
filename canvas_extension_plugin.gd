extends EditorPlugin
tool

var editor_interface = null

func get_name(): 
	return "CanvasExtension"

func _enter_tree():
	editor_interface = get_editor_interface()
	
	add_custom_type("BlendedColorRect", "Control", preload("blended_color_rect.gd"), editor_interface.get_base_control().get_icon("ColorRect", "EditorIcons"))
	add_custom_type("BlendedColorRibbon", "Control", preload("blended_color_ribbon.gd"), editor_interface.get_base_control().get_icon("ColorRect", "EditorIcons"))
	add_custom_type("BlendedTextureRect", "Control", preload("blended_texture_rect.gd"), editor_interface.get_base_control().get_icon("TextureRect", "EditorIcons"))
	add_custom_type("GridRect", "Control", preload("grid_rect.gd"), editor_interface.get_base_control().get_icon("GridContainer", "EditorIcons"))

func _exit_tree():
	remove_custom_type("BlendedColorRect")
	remove_custom_type("BlendedColorRibbon")
	remove_custom_type("BlendedTextureRect")
	remove_custom_type("GridRect")