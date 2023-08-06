extends CharacterBody2D

var speed : int = 400
var health : int = 100
var active : bool = true
var vulnerable : bool = true
var player_nearby : bool = false

func hit():
	if vulnerable : 
		vulnerable = false
		$Timers/HitTimer.start()
		health -= 15
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$AudioStreamPlayer2D.play()
		$Particles/HitParticles.emitting = true
	if health <= 0 :
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(delta):
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * delta * speed
		if active :
			move_and_slide()
			look_at(Globals.player_pos)

func _on_attack_area_2d_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("Attack")

func _on_attack_area_2d_body_exited(_body):
	player_nearby = false

func _on_notice_area_2d_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("Walk")

func _on_notice_area_2d_body_exited(_body):
	active = false
	
	$Timers/AttackTimer.start()

func _on_animated_sprite_2d_animation_finished():
	if player_nearby :
		Globals.health -= 10
		$Timers/AttackTimer.start()

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("Attack")

func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
