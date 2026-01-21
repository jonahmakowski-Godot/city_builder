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
@export var structure_rotation: int

@onready var collision_shape: CollisionShape3D = %TileCollisionShape
@onready var mesh: MeshInstance3D = %Mesh
@onready var structure_location: Node3D = %StructureLocation


func _ready():
	mesh.mesh = mesh.mesh.duplicate()
	collision_shape.shape = collision_shape.shape.duplicate()

	move_vertical()
	_update_structure()


func move_vertical():
	mesh.mesh.size.y = height
	collision_shape.shape.size.y = height

	var y_pos = height / 2.0
	mesh.global_position.y = y_pos
	collision_shape.global_position.y = y_pos
	structure_location.position.y = height


func _update_structure():
	for child in structure_location.get_children():
		child.queue_free()

	if cur_structure != null:
		var new_node := cur_structure.compile_mesh()
		new_node.rotate_y(deg_to_rad(structure_rotation))
		structure_location.add_child(new_node)


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Globals.currently_placing != null:
		structure_rotation = Globals.currently_placing_angle
		cur_structure = Globals.currently_placing.duplicate(true)
		get_viewport().set_input_as_handled()
