extends CanvasLayer


func _ready():
	get_tree().paused = true

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

func set_defeat():
	$%TitleLabel.text = "defeat"
	$%DescriptionLabel.text = "You Lost!"
