@tool
extends Node

var tiles: Array[Tile]
var currently_placing: Structure
var current_game_res: Game


func _ready():
	if FileAccess.file_exists("user://save_file.tres"):
		Globals.current_game_res = ResourceLoader.load("user://save_file.tres")
	else:
		Globals.current_game_res = Game.new()
		Globals.current_game_res.terrain_seed = randi()


func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		if event.is_action_pressed("rotate_object_right"):
			currently_placing.rotation += 90
			get_viewport().set_input_as_handled()
		if event.is_action_pressed("rotate_object_left"):
			currently_placing.rotation -= 90
			get_viewport().set_input_as_handled()


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("The app is closing!")
		var error = ResourceSaver.save(current_game_res, "user://save_file.tres")
		if error == OK:
			print("Successfully saved")
		else:
			print("Failed to save")


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


func apply_material(node: Node, material: StandardMaterial3D, overlay := false):
	if node is MeshInstance3D and node.mesh:
		if !overlay:
			node.material_override = material
		else:
			node.material_overlay = material
		return

	for child in node.get_children(true):
		apply_material(child, material, overlay)
