extends Node3D

@onready var enemy_big_scn = preload("res://Misc/enemy_big.tscn")
@onready var timer: Timer = $Timer

var can_spawn: bool = false
var max_spawn: int = 10
var spawned: int = 0
@export var big_enemy :bool = true

func _ready() -> void:
	# Connect timer only once
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	var distance_to_player = global_position.distance_to(Global.player_position)

	if distance_to_player < 200:
		if not can_spawn:
			can_spawn = true
			timer.start()
	else:
		if can_spawn:
			can_spawn = false
			timer.stop()
			_clear_enemies()

func _on_timer_timeout() -> void:
	if not can_spawn:
		return
	
	if spawned < max_spawn:
		if big_enemy == true:
			var enemy_big = enemy_big_scn.instantiate()
			$Marker3D.add_child(enemy_big)
			enemy_big.global_position = global_position
			spawned = $Marker3D.get_child_count()

func _clear_enemies() -> void:
	for enemy in $Marker3D.get_children():
		enemy.queue_free()
	spawned = 0
