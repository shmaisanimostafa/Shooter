extends CharacterBody2D

var player_nearby : bool = false
var vulnerable : bool = true
var active : bool = false
var speed : int = 200
var health = 100

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
	
func _physics_process(_delta):
	if active:
			var next_path_pos : Vector2 = $NavigationAgent2D.get_next_path_position()
			var direction : Vector2 = (next_path_pos - global_position).normalized()
			var look_angle = direction.angle()
			velocity = direction * speed
			rotation = look_angle + PI/2
			move_and_slide()
			
		
func _on_notice_area_body_entered(_body):
	$AnimationPlayer.play("Walk")

func _on_notice_area_body_exited(_body):
	active = false
	$AnimationPlayer.stop()

func _on_attack_area_body_entered(_body):
	player_nearby = true
	$AnimationPlayer.play("Attack")

func _on_attack_area_body_exited(_body):
	player_nearby = false
	

func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos

func attack():
	if player_nearby:
		Globals.health -= 20.

func hit():
	if vulnerable :
		health -= 5
		$Timers/HitTimer.start()
	if health <= 0:
		queue_free()

func _on_hit_timer_timeout():
	vulnerable = true
