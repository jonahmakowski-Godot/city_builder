@tool
class_name Structure
extends Resource

@export var mesh: PackedScene:
	set(val):
		if mesh != val:
			mesh = val
			emit_changed()
@export var name: String

var preview_mode = false


func compile_mesh() -> Node3D:
	var to_return = mesh.instantiate()
	if preview_mode:
		Globals.apply_material(to_return, preload("uid://cwrsujo7dfi43"))
	return to_return
