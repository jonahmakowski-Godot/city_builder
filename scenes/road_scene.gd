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

@onready var nav_region: NavigationRegion3D = %NavRegion


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

	"""
	var nav_instance := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	var aabb = Globals.get_aabb(mesh_node)

	nav_instance.mesh = mesh
	nav_instance.position = mesh_node.position + Vector3(0, aabb.size.y / 2, 0)
	nav_instance.hide()
	add_child(nav_instance)

	await get_tree().process_frame
	nav_region.bake_navigation_mesh()
	"""
