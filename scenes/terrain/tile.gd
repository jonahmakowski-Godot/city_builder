@tool
class_name Tile
extends StaticBody3D

@export var height: float:
	set(val):
		height = max(val, 0.5)
		if is_node_ready():
			move_vertical()
@export var cur_structure: Structure:
	set(val):
		cur_structure = val
		if is_node_ready():
			_update_structure()
@export var holo_structure: Structure

var tile_pos: Vector2i

@onready var collision_shape: CollisionShape3D = %TileCollisionShape
@onready var mesh: MeshInstance3D = %Mesh
@onready var structure_location: Node3D = %StructureLocation
@onready var holo_structure_location: Node3D = %HoloStructureLocation


func _ready():
	mesh.mesh = mesh.mesh.duplicate()
	collision_shape.shape = collision_shape.shape.duplicate()

	move_vertical()
	_update_structure()


func _process(_delta: float) -> void:
	if holo_structure != null:
		holo_structure_location.get_child(0).rotation_degrees.y = Globals.currently_placing.rotation

		if holo_structure.name != Globals.currently_placing.name:
			_update_holo_structure(true)


func move_vertical():
	mesh.mesh.size.y = height
	collision_shape.shape.size.y = height

	var y_pos = height / 2.0
	mesh.global_position.y = y_pos
	collision_shape.global_position.y = y_pos
	structure_location.position.y = height
	holo_structure_location.position.y = height


func _update_structure():
	for child in structure_location.get_children():
		child.queue_free()

	if cur_structure != null:
		var new_node := cur_structure.compile_mesh()
		new_node.rotation_degrees.y = cur_structure.rotation
		structure_location.add_child(new_node)
		Globals.current_game_res.buildings[tile_pos] = cur_structure


func _update_holo_structure(update := false):
	for child in holo_structure_location.get_children():
		child.queue_free()

	if Globals.currently_placing != null and update:
		holo_structure = Globals.currently_placing.duplicate(true)
		holo_structure.preview_mode = true

	if holo_structure != null:
		var new_node := holo_structure.compile_mesh()
		new_node.rotation_degrees.y = Globals.currently_placing.rotation
		holo_structure_location.add_child(new_node)
		if cur_structure != null:
			structure_location.get_child(0).visible = false
	elif cur_structure != null:
		structure_location.get_child(0).visible = true


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Globals.currently_placing != null:
		if event.is_pressed():
			cur_structure = Globals.currently_placing.duplicate(true)
			Globals.current_game_res.money -= cur_structure.construction_cost
			get_viewport().set_input_as_handled()


func _on_mouse_entered() -> void:
	if Globals.currently_placing != null:
		_update_holo_structure(true)


func _on_mouse_exited() -> void:
	holo_structure = null
	_update_holo_structure()
