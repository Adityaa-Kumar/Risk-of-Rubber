extends VehicleBody3D

#region export vars
@export var horsepower :float = 100.0
@export var reverse_power :float = -80.0
@export var steer_angle :float = 30.0
@export var acceleration :float = 2
@export var rev_acceleration :float = 5
@export var drag :float = 1
@export var steer_speed :float = 4.0
@export var brake_power :float = 6
@export var damage :int = 25
#endregion

#region reference
@onready var back_cam: PhantomCamera3D = %PlayerPhantomCamera3D
@onready var front_cam: PhantomCamera3D = %PlayerPhantomCamera3D2
@onready var area_3d: Area3D = $Area3D
@onready var player_scn = preload("res://Misc/player.tscn")
#endregion

##region player resources
#@export var player_resource :Reward
##endregion

#region onready vars
@onready var gpu_particles_3d_l: GPUParticles3D = $GPUParticles3D
#endregion

#region vars
var current_power :float = 0.0
var health :int = Global.player_health
var is_cam_back :bool = true
var speed :float
var is_dead :bool = false
#endregion

#regions funcs
func _ready() -> void:
	pass
	#player_resource = Reward.new()
	#player_resource.Ammo = 250

func _physics_process(delta: float) -> void:
	if not is_dead:
		engine_force = current_power
		speed = linear_velocity.length() * 3.6
		Global.player_speed = int(speed)
		Global.player_position = global_position
		
		if Input.is_action_pressed("throttle_up"):
			current_power = lerp(current_power, horsepower, acceleration * delta)
		elif Input.is_action_pressed("throttle_down"):
			current_power = lerp(current_power, reverse_power, rev_acceleration * delta)
		else:
			current_power = lerp(current_power, 0.0, drag * delta)
		
		if Input.is_action_pressed("steer_left"):
			steering = lerp_angle(steering, deg_to_rad(steer_angle), steer_speed * delta)
		elif Input.is_action_pressed("steer_right"):
			steering = lerp_angle(steering, deg_to_rad(-steer_angle), steer_speed * delta)
		else:
			steering = lerp_angle(steering, deg_to_rad(0.0), steer_speed * delta)
		
		gpu_particles_3d_l.emitting = true if engine_force else false
		
		if Input.is_action_pressed("brake"):
			brake = brake_power
		else:
			mass = 40
			brake = 0
		
		#Global.player_resource_global = player_resource
		
		if Input.is_action_just_pressed("rotate_cam") and is_cam_back:
			back_cam.priority = 0
			front_cam.priority = 1
			is_cam_back = false
		elif Input.is_action_just_pressed("rotate_cam") and not is_cam_back:
			back_cam.priority = 1
			front_cam.priority = 0
			is_cam_back = true
		
		if Input.is_action_just_pressed("reset"):
			self.rotation = Vector3.ZERO
		
		handle_health(delta)
		
		if Input.is_action_just_pressed("parking_brake"):
			take_damage(20)
		

func handle_health(delta):
	if Global.player_health < 50:
		$smoke.emitting = true
	if Global.player_health <= 0 and not is_dead:
		$wheelFrontLeft.queue_free()
		$wheelFrontRight.queue_free()
		$wheelBackLeft.queue_free()
		$wheelBackRight.queue_free()
		$turret.queue_free()
		is_dead = true
		apply_impulse(Vector3(0.0, 500.0, 0.0), Vector3.ZERO)
		Engine.time_scale = 0.2
		$death.visible = true
		$death.play("default")
		$MainCamera3D/AnimationPlayer.play("death")
		await  $MainCamera3D/AnimationPlayer.animation_finished
		await  get_tree().create_timer(10, true, false, true).timeout
		spawn_player()
		

#func set_resource(resource :Reward) -> void:
	#player_resource.Ammo += resource.Ammo
	#player_resource.Metal += resource.Metal
	#player_resource.Parley_JEE += resource.Parley_JEE

func take_damage(damage :int):
	Global.player_health -= damage

func spawn_player() -> void:
	$MainCamera3D/UI.queue_free()
	$MainCamera3D/CenterContainer.queue_free()
	$MainCamera3D/AnimationPlayer.play("RESET")
	var player = player_scn.instantiate()
	var spawn_pos = global_position + Vector3(0.0, 5.0, 0.0)
	get_tree().current_scene.add_child(player)
	player.global_position = spawn_pos
#endregion

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Ground"):
		if speed > 100:
			take_damage(10)
