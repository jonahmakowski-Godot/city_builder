extends CharacterBody3D

const SPEED := 5


func _physics_process(_delta: float) -> void:
	# Rotation
	var rotation_input = Input.get_axis("rotate_right", "rotate_left")
	rotate_y(deg_to_rad(rotation_input))

	# Forward/Back/Left/Right movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Apply movement
	velocity.x = movement_dir.x * SPEED
	velocity.z = movement_dir.z * SPEED
	velocity.y = Input.get_axis("move_down", "move_up") * SPEED

	move_and_slide()
