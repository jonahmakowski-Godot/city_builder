@tool
class_name Structure
extends Resource

@export var mesh: PackedScene:
	set(val):
		if mesh != val:
			mesh = val
			emit_changed()
@export var name: String
@export var construction_cost: int
@export var maintenance_cost: int
@export_category("No Editing!")
@export var rotation: int

var preview_mode: bool = false:
	set(val):
		if val != preview_mode:
			preview_mode = val
			emit_changed()


func compile_mesh() -> Node3D:
	var to_return = mesh.instantiate()
	if preview_mode:
		Globals.apply_material(to_return, preload("uid://cwrsujo7dfi43"))
	return to_return
