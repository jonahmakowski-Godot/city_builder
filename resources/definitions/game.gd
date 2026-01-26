class_name Game
extends Resource

signal money_changed
signal population_changed

@export var terrain_seed: int
@export var money: int:
	set(val):
		if val != money:
			money = val
			money_changed.emit()
@export var population: int:
	set(val):
		if val != population:
			population = val
			population_changed.emit()
@export var buildings: Dictionary[Vector2i, Structure]
