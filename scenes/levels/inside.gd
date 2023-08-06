extends LevelParent

func _on_transition_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 1)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
