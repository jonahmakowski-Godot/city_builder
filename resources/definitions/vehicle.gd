@tool
class_name vehicle
extends Resource

enum VECHILE_TYPE { CAR, TRUCK, PERSON_TRAIN, CARGO_TRAIN, PERSON_BOAT, CARGO_BOAT, BUS }

@export var name: String
@export var vechile_type: VECHILE_TYPE:
	set(val):
		vechile_type = val
		is_cargo = true if (val == 1 or vechile_type == 3 or vechile_type == 5) else false
		is_train = true if (val == 3 or val == 4) else false
		is_boat = true if (val == 4 or val == 5) else false
		is_transport = true if (val == 2 or val == 4 or val == 6) else false
@export var speed: int
@export var model: PackedScene
@export_category("Anything People")
@export var person_capacity: int
@export_category("Anything Cargo")
@export var cargo_capacity: int

var is_cargo
var is_train
var is_boat
var is_transport
