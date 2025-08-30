extends Area3D

@export var reward_resource :Reward

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Global.metal += 10
		$Chest.visible = false
		$AnimatedSprite3D.no_depth_test = true
		$AnimatedSprite3D.visible = true
		$AnimatedSprite3D.play("default")
		await  $AnimatedSprite3D.animation_finished
		Global.save_game()
		queue_free()
