@tool
class_name Building
extends Structure


func compile_mesh() -> Node3D:
	var to_return = BuildingScene.create()
	to_return.building = self
	to_return.scale = Vector3(0.75, 0.75, 0.75)
	if preview_mode:
		Globals.apply_material(to_return, preload("uid://cwrsujo7dfi43"))
	return to_return
