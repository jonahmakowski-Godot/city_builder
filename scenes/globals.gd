@tool
extends Node

var tiles: Array[Tile]
var currently_placing: Structure
var currently_placing_angle: int


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate_object_right"):
		currently_placing_angle += 90
		get_viewport().set_input_as_handled()
	if event.is_action_pressed("rotate_object_left"):
		currently_placing_angle -= 90
		get_viewport().set_input_as_handled()


func get_aabb(node: Node3D) -> AABB:
	if not node.is_node_ready():
		print("Running on node that isn't ready, terminating")
		return AABB()

	if not node.is_inside_tree():
		print("Node not in scene tree: ", node.name)
		return AABB()

	var aabb = AABB()
	for child in node.get_children():
		if child is MeshInstance3D:
			aabb = aabb.merge(child.get_aabb())
		elif child is Node3D:
			aabb = aabb.merge(get_aabb(child))
	return aabb


func apply_material(node: Node3D, material: StandardMaterial3D):
	if node is MeshInstance3D:
		node.material_override = material

	for child in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		else:
			apply_material(child, material)
