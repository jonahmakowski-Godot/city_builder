@tool
extends Node

var tiles: Array[Tile]


func get_aabb(node) -> AABB:
	var aabb = AABB()
	for child in node.get_children():
		if child is MeshInstance3D:
			aabb = aabb.merge(child.get_aabb())
		elif child is Node3D:
			aabb = aabb.merge(get_aabb(child))
	return aabb
