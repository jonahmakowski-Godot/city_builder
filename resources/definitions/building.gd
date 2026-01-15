@tool
class_name Building
extends Resource

signal model_change

@export var model: PackedScene:
	set(val):
		model = val
		model_change.emit()
@export var name: String
