@tool
extends StaticBody3D

@export var building: Building:
	set(val):
		if building:
			building.model_change.disconnect(update_model)

		if val:
			val.model_change.connect(update_model)

		building = val
		update_model()

var model: Node3D

@onready var collision_shape: CollisionShape3D = %CollisionShape


func _ready() -> void:
	update_model()


func _process(delta: float) -> void:
	pass


func update_model():
	for child in get_children():
		if child is not CollisionShape3D:
			child.queue_free()

	if building and building.model:
		model = building.model.instantiate()
		add_child(model)
		if collision_shape:
			set_collisions()


func set_collisions():
	var aabb := Globals.get_aabb(model)
	var box := BoxShape3D.new()
	box.size = aabb.size
	collision_shape.shape = box
	collision_shape.position.y = box.size.y / 2
