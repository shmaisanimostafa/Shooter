extends CharacterBody2D

var player_nearby : bool = false
var can_laser : bool = true
var health : int = 100
var vulnerable : bool = true

signal laser(pos, direction)

func _process(_delta):
	if player_nearby :
		look_at(Globals.player_pos)
		if can_laser :
			var pos : Vector2 = $LaserSpawnPositions.get_children().pick_random().global_position
			var direction : Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/HitCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true

func _on_hit_cooldown_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)

func hit():
	if vulnerable == true:
		health -= 50
		$Timers/HitCooldown.start()
		$AudioStreamPlayer2D.play()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0 :
		queue_free()
	vulnerable = false
