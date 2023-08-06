extends Area2D

@export var speed: int = 2000
var direction

func _ready():
	$Timer.start()
	$AudioStreamPlayer2D.play()

func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit()
	queue_free()

func _on_timer_timeout():
	queue_free()
