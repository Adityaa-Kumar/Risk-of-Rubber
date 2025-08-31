extends CharacterBody3D

@export var speed :float = 6.0
@export var health :float = 100.0
@export var damage :float = 5.0
var direction :Vector3 = Vector3.ZERO

var is_attacking :bool = false

func _physics_process(delta: float) -> void:
	var distance_to_player = global_position.distance_to(Global.player_position)
	if not is_attacking:
		direction = global_position.direction_to(Global.player_position)
	else:
		direction = Vector3.ZERO
		velocity = Vector3.ZERO
	
	velocity.y -= 30
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
	
	if direction:
		$AnimatedSprite3D.play("walk")
	if health <= 0:
		Global.score += 5
		queue_free()
	
	if distance_to_player > 200:
		queue_free()
	

func take_damage(damage :int):
	health -= damage
	$AnimatedSprite3D.modulate = Color(1.0, 0.0, 0.0)
	await get_tree().create_timer(0.2).timeout
	$AnimatedSprite3D.modulate = Color(1.0, 1.0, 1.0)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if Global.player_speed > 60:
			take_damage(50)
		elif Global.player_speed > 90:
			take_damage(100)
		is_attacking = true
		$AnimatedSprite3D.play("attack")
		await $AnimatedSprite3D.animation_finished
		if body.has_method("take_damage"):
			body.take_damage(5)
		is_attacking = false
