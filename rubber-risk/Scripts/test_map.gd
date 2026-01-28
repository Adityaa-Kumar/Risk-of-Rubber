extends Node3D

@onready var pickup_scn = preload("res://Vehicles/pickup_armoured.tscn")
@onready var sedan_scn = preload("res://Vehicles/sedan_armoured.tscn")
@onready var truck_scn = preload("res://Vehicles/truck_armoured.tscn")
@onready var player_spawn: Node3D = $player_spawn

func _ready() -> void:
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
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("esc") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
