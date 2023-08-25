extends CharacterBody2D


signal laser(pos, direction)
signal grenade(pos, direction)


var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500

var speed: int = max_speed



func _process(_delta):
	# movement input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed 
	move_and_slide()
	Globals.player_pos = global_position
	# rotation
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		# Decrement the laser amount
		Globals.laser_amount -= 1
		# Select random marker2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers.pick_random()
		can_laser = false
		$Timer.start()
		$WeaponFlame.position = $LaserStartPositions/Marker2D2.position
#		$WeaponFlame.position = selected_laser
		$WeaponFlame.emitting = true
		# Emit position to the laser
		laser.emit(selected_laser.global_position, player_direction)

	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		# Decrement the grenade amount
		Globals.grenade_amount -= 1
		var selected_grenade = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade.emit(selected_grenade, player_direction)


func _on_timer_timeout():
	can_laser = true


func _on_timer_2_timeout():
	can_grenade = true


func hit():
	Globals.health -= 1
