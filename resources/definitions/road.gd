@tool
class_name Road
extends Structure

@export var thumbnail: CompressedTexture2D:
	set(val):
		if thumbnail != val:
			thumbnail = val
			emit_changed()


func compile_mesh() -> Node3D:
	var to_return = load("uid://chseeoex5wbpr").instantiate()
	to_return.res = self.duplicate(true)
	if preview_mode:
		Globals.apply_material(to_return, preload("uid://cwrsujo7dfi43"))
	return to_return
