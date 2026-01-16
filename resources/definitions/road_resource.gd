class_name RoadResource
extends Resource

@export var mesh: PackedScene:
	set(val):
		if mesh != val:
			mesh = val
			emit_changed()
@export var thumbnail: CompressedTexture2D:
	set(val):
		if thumbnail != val:
			thumbnail = val
			emit_changed()
