extends Control

@export var roads: Array[Road]

# Main Menu Buttons
@onready var road: TextureButton = %Road
@onready var residential: TextureButton = %Residential
@onready var commercial: TextureButton = %Commercial
@onready var industrial: TextureButton = %Industrial
# Sub-menus
@onready var roads_menu: HBoxContainer = %RoadsMenu
@onready var road_hider: PanelContainer = %RoadHider
# Labels
@onready var money: Label = %Money
@onready var population: Label = %Population


func _ready():
	road.pressed.connect(_toggle_road_menu)
	load_roads()
	Globals.current_game_res.money_changed.connect(_update_money)
	Globals.current_game_res.population_changed.connect(_update_population)


func load_roads():
	for r in roads:
		var button := TextureButton.new()
		button.pressed.connect(set_current_building.bind(r))
		button.texture_normal = r.thumbnail
		button.tooltip_text = r.name
		roads_menu.add_child(button)


func set_current_building(building: Structure):
	Globals.currently_placing = building


func _update_money():
	money.text = "Money: $" + str(Globals.current_game_res.money)


func _update_population():
	money.text = "Population: " + str(Globals.current_game_res.population)


func _toggle_road_menu():
	road_hider.visible = !road_hider.visible
