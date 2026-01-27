extends Node

var astar: AStar3D

@onready var game: GameScene = get_parent()


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_roads():
	astar = AStar3D.new()

	var structures := Globals.current_game_res.buildings

	var path_data: Array[PackedVector3Array]

	for st in structures:
		if structures[st] is not Road:
			continue

		var cur_road := structures[st] as Road

		if len(cur_road.path_points) == 0:
			push_warning("Road without path located at %s, %s" % [st.x, st.y])
			continue

		for path in cur_road.path_points:
			var path_points_raw := path.get_baked_points()
			var path_points: PackedVector3Array

			for point in path_points_raw:
				path_points.append(point + Vector3(st.x, game.height_map[st], st.y))

			var path_index = 0
			var got_added = false
			for point in path_points:
				for array in path_data:
					if point == array[0] or point == array[len(array) - 1]:
						var first = true
						if point == array[len(array) - 1]:
							first = false

						if not first:
							array.push_back(path_points[0 if path_index == 1 else 1])
						else:
							array.insert(0, path_points[0 if path_index == 1 else 1])

						got_added = true
				path_index += 1

			if not got_added:
				path_data.append(path_points)

	for array in path_data:
		print("\n\n-- New Array --")
		for vec in array:
			print(vec)
