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


func load_roads():
	for r in roads:
		var button := TextureButton.new()
		button.pressed.connect(set_current_building.bind(r))
		button.texture_normal = r.thumbnail
		button.tooltip_text = r.name
		roads_menu.add_child(button)


func set_current_building(building: Structure):
	Globals.currently_placing = building


func _toggle_road_menu():
	road_hider.visible = !road_hider.visible
