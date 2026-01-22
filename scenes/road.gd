@tool
class_name RoadScene
extends Node3D

@export var res: Road:
	set(new_val):
		if res != null:
			res.changed.disconnect(_on_res_changed)
		res = new_val
		if res != null:
			res.changed.connect(_on_res_changed)
			if is_node_ready() and is_inside_tree():
				_on_res_changed()

var mesh_node: Node3D = null

@onready var paths: Node3D = %Paths


func _ready() -> void:
	_on_res_changed()


func _on_res_changed():
	# Mesh System
	if mesh_node != null:
		mesh_node.queue_free()
	mesh_node = res.mesh.instantiate()
	if res.preview_mode:
		Globals.apply_material(mesh_node, preload("uid://cwrsujo7dfi43"), true)
	add_child(mesh_node)

	# Nav system
	for child in paths.get_children():
		child.queue_free()

	for path in res.path_points:
		var new_path_node = Path3D.new()
		new_path_node.curve = res.path_points
