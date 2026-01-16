@tool
extends Node3D

const map_size: int = 100
const magnitude: float = 10.0

@export var run_terrain_in_editor: bool = false
@export var terrain_noise: FastNoiseLite
@export var tile_scene: PackedScene

@onready var terrain_folder: Node3D = %TerrainFolder


func _ready() -> void:
	if !Engine.is_editor_hint() or run_terrain_in_editor:
		terrain_gen(randi())


func terrain_gen(s: int):
	terrain_noise.seed = s
	for x in range(map_size):
		for y in range(map_size):
			var height := int((terrain_noise.get_noise_2d(x, y) + 1) * magnitude * 2) * 0.5
			var tile: Tile = tile_scene.instantiate()
			tile.height = height
			terrain_folder.add_child(tile)
			tile.global_position = Vector3(x, 0, y)
