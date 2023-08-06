extends Area2D

const speed : int = 5
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'grenade', 'health']
var type = available_options.pick_random()
var direction : Vector2
var distance : int = randi_range(150, 250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color.BLUE
	if type == 'grenade':
		$Sprite2D.modulate = Color.BLACK
	if type == 'health':
		$Sprite2D.modulate = Color.RED
		
	# Tweens
	var target_position = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0,0))
		
func _process(delta):
	rotation += speed * delta
 
func _on_body_entered(_body):
	if type == 'laser':
		Globals.laser_amount += 20
	if type == 'grenade':
		Globals.grenade_amount += 1
	if type == 'health':
		Globals.health += 10
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
