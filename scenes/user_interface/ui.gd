extends CanvasLayer

# Labels (Texts)
@onready var laser_label : Label = $BulltetCounter/VBoxContainer/Label
@onready var grenade_label : Label = $GrenadeCounter/VBoxContainer/Label

# Textures (Icons)
@onready var laser_icon : TextureRect = $BulltetCounter/VBoxContainer/TextureRect
@onready var grenade_icon : TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# Colors
var green : Color = Color.FOREST_GREEN
var red : Color = Color("84001a")

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func update_health_text():
	health_bar.value = Globals.health

func update_stat_text():
	update_grenade_text()
	update_laser_text()
	update_health_text()

func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()

func update_color(amount : int, label: Label, icon : TextureRect):
	if amount > 0:
		label.modulate = green
		icon.modulate = green
	else: 
		label.modulate = red
		icon.modulate = red
