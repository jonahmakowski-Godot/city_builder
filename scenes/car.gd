@tool
extends AnimatableBody3D

@export var res: Vehicle:
	set(val):
		if res != null:
			res.changed.disconnect(_update_mesh)

		if val != null:
			val.changed.connect(_update_mesh)

		res = val

		if is_node_ready():
			_update_mesh()

var mesh: Node3D

@onready var collision_shape: CollisionShape3D = %CollisionShape
@onready var ray_cast_3d: RayCast3D = %RayCast3D


func _ready():
	_update_mesh()


func _update_mesh():
	if mesh != null:
		mesh.queue_free()

	if res != null:
		mesh = res.model.instantiate()
		add_child(mesh)

		var aabb := Globals.get_aabb(mesh)

		collision_shape.shape.size = aabb.size
		collision_shape.position = Vector3(0, aabb.size.y / 2, 0)
