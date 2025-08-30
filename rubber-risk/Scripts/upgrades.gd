extends Node3D
@onready var pickup_armour: Node3D = $car_selector/pickup_armour
@onready var sedan_armour: Node3D = $car_selector/sedan_armour
@onready var truck_armour: Node3D = $car_selector/truck_armour
@onready var label_metal: Label = $Camera3D/CanvasLayer/Resources/Label_metal
@onready var label_parley_jee: Label = $Camera3D/CanvasLayer/Resources/Label_Parley_JEE
@onready var label_health: Label = $Camera3D/CanvasLayer/Vehicle_Stats/Label_health
@onready var label_max_health: Label = $Camera3D/CanvasLayer/Vehicle_Stats/Label_max_health

func _ready() -> void:
	if Global.selected_car == Global.vehicle.PICKUP:
		sedan_armour.visible = false
		pickup_armour.visible = true
		truck_armour.visible = false
	elif Global.selected_car == Global.vehicle.SEDAN:
		sedan_armour.visible = true
		pickup_armour.visible = false
		truck_armour.visible = false
	elif Global.selected_car == Global.vehicle.TRUCK:
		sedan_armour.visible = false
		pickup_armour.visible = false
		truck_armour.visible = true

func _process(delta: float) -> void:
	label_metal.text = "Metal: "+str(Global.metal)
	label_parley_jee.text = "Parley-JEE: "+str(Global.parley_jee)
	if Global.selected_car == Global.vehicle.PICKUP:
		label_health.text = "Health: "+str(Global.pickup_health)
		label_max_health.text = "Max Health: "+str(Global.pickup_max_health)
	elif Global.selected_car == Global.vehicle.SEDAN:
		label_health.text = "Health: "+str(Global.sedan_health)
		label_max_health.text = "Max Health: "+str(Global.sedan_max_health)
	elif Global.selected_car == Global.vehicle.TRUCK:
		label_health.text = "Health: "+str(Global.truck_health)
		label_max_health.text = "Max Health: "+str(Global.truck_max_health)

func _on_button_2_pressed() -> void:
	get_tree().quit(0)

func _on_button_3_pressed() -> void:
	if pickup_armour.visible == true:
		sedan_armour.visible = true
		pickup_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.SEDAN
	elif sedan_armour.visible == true:
		pickup_armour.visible = false
		sedan_armour.visible = false
		truck_armour.visible = true
		Global.selected_car = Global.vehicle.TRUCK
	elif truck_armour.visible == true:
		pickup_armour.visible = true
		sedan_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.PICKUP

func _on_button_4_pressed() -> void:
	if pickup_armour.visible == true:
		sedan_armour.visible = false
		pickup_armour.visible = false
		truck_armour.visible = true
		Global.selected_car = Global.vehicle.TRUCK
	elif sedan_armour.visible == true:
		pickup_armour.visible = true
		sedan_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.PICKUP
	elif truck_armour.visible == true:
		pickup_armour.visible = false
		sedan_armour.visible = true
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.SEDAN


func _on_button_5_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/home_base.tscn")

func _on_health_up_pressed() -> void:
	if Global.metal >= 10:
		if Global.selected_car == Global.vehicle.PICKUP:
			Global.pickup_max_health += 10
			Global.metal -= 10
			Global.parley_jee -= 10
		elif Global.selected_car == Global.vehicle.SEDAN:
			Global.sedan_max_health += 10
			Global.metal -= 10
			Global.parley_jee -= 10
		elif Global.selected_car == Global.vehicle.TRUCK:
			Global.truck_max_health += 10
			Global.metal -= 10
			Global.parley_jee -= 10

func _on_ammo_up_pressed() -> void:
	if Global.metal >= 10:
		var heal_amount = 0
		if Global.selected_car == Global.vehicle.PICKUP and Global.pickup_health < Global.pickup_max_health:
			heal_amount = min(10, Global.pickup_max_health - Global.pickup_health)
			Global.pickup_health += heal_amount
		elif Global.selected_car == Global.vehicle.SEDAN and Global.sedan_health < Global.sedan_max_health:
			heal_amount = min(10, Global.sedan_max_health - Global.sedan_health)
			Global.sedan_health += heal_amount
		elif Global.selected_car == Global.vehicle.TRUCK and Global.truck_health < Global.truck_max_health:
			heal_amount = min(10, Global.truck_max_health - Global.truck_health)
			Global.truck_health += heal_amount
		
		if heal_amount > 0:
			Global.metal -= heal_amount
			Global.parley_jee -= heal_amount
