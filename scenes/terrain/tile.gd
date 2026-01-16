@tool
class_name Tile
extends StaticBody3D

@export var height: float:
	set(val):
		height = max(val, 0.5)
		if is_node_ready():
			move_vertical()

@onready var collision_shape: CollisionShape3D = %CollisionShape
@onready var mesh: MeshInstance3D = %Mesh


func _ready():
	mesh.mesh = mesh.mesh.duplicate()
	collision_shape.shape = collision_shape.shape.duplicate()

	move_vertical()


func move_vertical():
	mesh.mesh.size.y = height
	collision_shape.shape.size.y = height

	var y_pos = height / 2.0
	mesh.global_position.y = y_pos
	collision_shape.global_position.y = y_pos
