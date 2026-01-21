@tool
class_name BuildingScene
extends StaticBody3D

@export var building: Building:
	set(val):
		if building:
			building.changed.disconnect(update_model)

		if val:
			val.changed.connect(update_model)

		building = val

		update_model()

var model: Node3D

@onready var collision_shape: CollisionShape3D = %CollisionShape


static func create() -> BuildingScene:
	return preload("uid://d0sq31t3myy6q").instantiate()


func _ready() -> void:
	if not is_inside_tree():
		print("  Parent: ", get_parent().name if get_parent() else "None")
		print("  Root: ", get_tree().root.name if get_tree().root else "None")
	update_model()


func _process(delta: float) -> void:
	pass


func update_model():
	if not is_node_ready() or not is_inside_tree():
		return

	if model != null:
		model.queue_free()

	if building and building.mesh:
		model = building.mesh.instantiate()
		add_child(model)
		if collision_shape:
			set_collisions()


func set_collisions():
	var aabb := Globals.get_aabb(model)
	var box := BoxShape3D.new()
	box.size = aabb.size
	collision_shape.shape = box
	collision_shape.position.y = box.size.y / 2
