extends Control

@export var roads: Array[RoadResource]

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
		var button = TextureButton.new()
		button.texture_normal = r.thumbnail
		roads_menu.add_child(button)


func _toggle_road_menu():
	road_hider.visible = !road_hider.visible
