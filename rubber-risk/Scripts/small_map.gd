extends Node3D

@onready var pickup_scn = preload("res://Vehicles/pickup_armoured.tscn")
@onready var sedan_scn = preload("res://Vehicles/sedan_armoured.tscn")
@onready var truck_scn = preload("res://Vehicles/truck_armoured.tscn")
@onready var player_spawn: Node3D = $player_spawn

func _ready() -> void:
	Global.load_game()
	if Global.selected_car == Global.vehicle.PICKUP:
		Global.player_health = Global.pickup_health
	elif Global.selected_car == Global.vehicle.SEDAN:
		Global.player_health = Global.sedan_health
	elif Global.selected_car == Global.vehicle.TRUCK:
		Global.player_health = Global.truck_health
	if Global.selected_car == Global.vehicle.PICKUP:
		var player = pickup_scn.instantiate()
		player_spawn.add_child(player)
		player.top_level = true
	elif Global.selected_car == Global.vehicle.SEDAN:
		var player = sedan_scn.instantiate()
		player_spawn.add_child(player)
		player.top_level = true
	elif Global.selected_car == Global.vehicle.TRUCK:
		var player = truck_scn.instantiate()
		player_spawn.add_child(player)
		player.top_level = true
		
	
func _process(delta: float) -> void:
	if Global.selected_car == Global.vehicle.PICKUP:
		var player = pickup_scn.instantiate()
		if player.global_trandform.origin.y <= -100:
			player.global_transform.origin = player_spawn.global_transform.origin
	elif Global.selected_car == Global.vehicle.SEDAN:
		var player = sedan_scn.instantiate()
		if player.global_trandform.origin.y <= -100:
			player.global_transform.origin = player_spawn.global_transform.origin
	elif Global.selected_car == Global.vehicle.TRUCK:
		var player = truck_scn.instantiate()
		if player.global_trandform.origin.y <= -100:
			player.global_transform.origin = player_spawn.global_transform.origin
