extends Node

var player_vulnerable : bool = true

signal stat_change

var player_hit_sound : AudioStreamPlayer2D 
var enemies_count = 1
var scouts_amount = 1
var drones_amount = 1

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()

var health = 100:
	set(value):
		if value > health : 
			health = min(value, 100)
			print(health)
		else :
			if player_vulnerable : 
				health = value
				player_vulnerable = false
				player_vulnerable_timer()
				player_hit_sound.play()
		stat_change.emit()

var player_pos : Vector2

func player_vulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
