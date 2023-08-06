extends RigidBody2D

const speed =  750
var explosion_radius: int = 400
var explosion_active: bool = false

func explode():
	$AnimationPlayer.play("Explode")
	explosion_active = true
	
func _process(_delta):
	if explosion_active :
		var targets : Array = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for target in targets :
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()

