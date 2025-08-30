extends Node

var player_resource_global :Reward
var player_health :int
var ammo :int
enum vehicle {PICKUP, SEDAN, TRUCK}
var selected_car :vehicle
var player_speed :int
var player_position :Vector3

var save_data = SaveData.new()

var score: int = 0
var metal: int = 0
var parley_jee: int = 0
var pickup_max_health: int = 100
var sedan_max_health: int = 100
var truck_max_health: int = 100
var pickup_health: int = 100
var sedan_health: int = 100
var truck_health: int = 100

func _ready() -> void:
	ammo = 250
	load_game()

func save_game():
	var save_data = SaveData.new()
	save_data.score = score
	save_data.pickup_max_health = pickup_max_health
	save_data.sedan_max_health = sedan_max_health
	save_data.truck_max_health = truck_max_health
	save_data.metal = metal
	save_data.parley_jee = parley_jee
	save_data.pickup_health = pickup_health
	save_data.sedan_health = sedan_health
	save_data.truck_health = truck_health
	ResourceSaver.save(save_data, "user://savegame.tres")

func load_game():
	if ResourceLoader.exists("user://savegame.tres"):
		var save_data = ResourceLoader.load("user://savegame.tres")
		score = save_data.score
		pickup_max_health = save_data.pickup_max_health
		sedan_max_health = save_data.sedan_max_health
		truck_max_health = save_data.truck_max_health
		metal = save_data.metal
		parley_jee = save_data.parley_jee
		pickup_health = save_data.pickup_health
		sedan_health = save_data.sedan_health
		truck_health = save_data.truck_health
