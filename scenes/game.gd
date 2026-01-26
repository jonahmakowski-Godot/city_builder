@tool
extends Node3D

const map_size: int = 100
const magnitude: float = 15.0

@export var run_terrain_in_editor: bool = false
@export var terrain_noise: FastNoiseLite
@export var tile_scene: PackedScene

@onready var terrain_folder: Node3D = %TerrainFolder


func _ready() -> void:
	if !Engine.is_editor_hint() or run_terrain_in_editor:
		start_terrain_gen_thread()


func start_terrain_gen_thread():
	var thread: Thread = Thread.new()
	thread.start(terrain_gen)


func terrain_gen():
	if not terrain_folder.is_node_ready():
		await terrain_folder.ready

	terrain_noise.seed = Globals.current_game_res.terrain_seed
	for x in range(map_size):
		for y in range(map_size):
			var height := int((terrain_noise.get_noise_2d(x, y) + 1) * magnitude * 2) * 0.25
			var tile: Tile = tile_scene.instantiate()
			tile.height = height
			tile.tile_pos = Vector2i(x, y)
			if Vector2i(x, y) in Globals.current_game_res.buildings.keys():
				tile.cur_structure = Globals.current_game_res.buildings[Vector2i(x, y)]
			terrain_folder.call_deferred("add_child", tile)
			await tile.ready
			tile.global_position = Vector3(x, 0, y)
