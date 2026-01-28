extends CharacterBody3D

@onready var head = $head
var mouse_sensitivity = 0.1

var gravity = 9.8
var speed = 8.0
var jump_speed = 6.0
var can_fire :bool = true
var ads :bool = false
var time_accumulator :float = 0.0
var can_radiate :bool = false

func _ready() -> void:
	Engine.time_scale = 1.0
	$head/Camera3D.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$AnimationPlayer.play("ready")
	await $AnimationPlayer.animation_finished
	$head/Camera3D/Control/TextureRect.queue_free()
	$head/Camera3D/Control/Label_death.queue_free()
	$Timer.start()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("esc") and Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Global.player_position = global_position
	print(Global.player_position)
	
	if Input.is_action_just_pressed("aim") and not ads:
		$AnimationPlayer.play("ADS")
		ads = true
		await $AnimationPlayer.animation_finished
	elif Input.is_action_just_pressed("aim") and ads:
		$AnimationPlayer.play_backwards("ADS")
		ads = false
		await $AnimationPlayer.animation_finished
	

func _physics_process(delta: float) -> void:
	velocity.y -= gravity * delta
	
	var input_vector = Input.get_vector("steer_left", "steer_right", "throttle_up", "throttle_down");
	var direction = transform.basis * Vector3(input_vector.x, 0, input_vector.y)
	
	if is_on_floor():
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed 
	
	if is_on_floor() and Input.is_action_just_pressed("brake"):
		velocity.y = jump_speed
	
	move_and_slide()
	
	if Input.is_action_pressed("fire") and can_fire and not ads:
		$AnimationPlayer.play("fire")
		fire()
		can_fire = false
	elif Input.is_action_pressed("fire") and can_fire and ads:
		$AnimationPlayer.play("ads_fire")
		fire()
		can_fire = false
	
	radiation(delta)
	if Global.player_health <= 0:
		die()
	

func die() -> void:
	print("dead")
	get_tree().change_scene_to_file("res://Map/menu.tscn")

func radiation(delta) -> void:
	$head/Camera3D/Control/ProgressBar.value = Global.player_health

func fire() -> void:
	if $head/Camera3D/RayCast3D.is_colliding():
		var collider = $head/Camera3D/RayCast3D.get_collider()
		if collider.is_in_group("Enemy") and collider.has_method("take_damage"):
			collider.take_damage(25)
		

func take_damage(damage :int):
	Global.player_health -= damage

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	can_fire = true

func _on_timer_timeout() -> void:
	take_damage(1)
	$Timer.start()
