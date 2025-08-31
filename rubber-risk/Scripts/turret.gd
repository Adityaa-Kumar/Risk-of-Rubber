extends Node3D

@export var mouse_sensitivity :float = 0.06
@onready var gun: Node3D = $gun
@onready var ray_cast_3d: RayCast3D = $gun/RayCast3D
@onready var sprite_3d: Sprite3D = $gun/Sprite3D
@onready var gpu_particles_3d: GPUParticles3D = $gun/GPUParticles3D
var can_fire :bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$gun/MeshInstance3D.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		gun.rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity))
		gun.rotation.x = clamp(gun.rotation.x, deg_to_rad(-5), deg_to_rad(8))
	
	if Input.is_action_pressed("fire"):
		gpu_particles_3d.emitting = true
		if can_fire and Global.ammo > 0:
			can_fire = false
			$Timer.start()
			await $Timer.timeout
			if ray_cast_3d.is_colliding():
				var collider = ray_cast_3d.get_collider()
				if is_instance_valid(collider):
					if collider.is_in_group("Enemy") and collider.has_method("take_damage"):
						collider.take_damage(25)
			Global.ammo -= 1
			can_fire = true
	else:
		gpu_particles_3d.emitting = false
	

func _process(delta: float) -> void:
	if ray_cast_3d.is_colliding():
		var hit_pos :Vector3 = ray_cast_3d.get_collision_point()
		sprite_3d.global_position = hit_pos
	else:
		sprite_3d.global_position = ray_cast_3d.global_transform.origin + ray_cast_3d.global_transform.basis * ray_cast_3d.target_position
	
