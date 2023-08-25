extends CanvasLayer

# Labels (Texts)
@onready var laser_label : Label = $BulltetCounter/VBoxContainer/Label
@onready var grenade_label : Label = $GrenadeCounter/VBoxContainer/Label
@onready var scout_label : Label = $SniperContainer/VBoxContainer/Label
@onready var drone_label : Label = $DroneContainer/VBoxContainer/Label

# Textures (Icons)
@onready var drone_icon : TextureRect = $DroneContainer/VBoxContainer/TextureRect
@onready var scout_icon : TextureRect = $SniperContainer/VBoxContainer/TextureRect
@onready var laser_icon : TextureRect = $BulltetCounter/VBoxContainer/TextureRect
@onready var grenade_icon : TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar


# Colors
var green : Color = Color.FOREST_GREEN
var red : Color = Color("84001a")



func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()
	update_drone_text()
	update_scout_text()
	
	

func _process(_delta):
	Globals.enemies_count = Globals.scouts_amount + Globals.drones_amount


func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)


func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)


func update_drone_text():
	Globals.drones_amount = get_tree().get_nodes_in_group("Drones").size()
	drone_label.text = str(Globals.drones_amount)
	update_color_enemies(Globals.drones_amount, drone_label, drone_icon)


func update_scout_text():
	Globals.scouts_amount = get_tree().get_nodes_in_group("Scouts").size()
	scout_label.text = str(Globals.scouts_amount)
	update_color_enemies(Globals.scouts_amount, scout_label, scout_icon)


func update_health_text():
	health_bar.value = Globals.health


func update_stat_text():
	update_grenade_text()
	update_laser_text()
	update_health_text()
	update_drone_text()
	update_scout_text()


func update_color(amount : int, label: Label, icon : TextureRect):
	if amount > 0:
		label.modulate = green
		icon.modulate = green
	else: 
		label.modulate = red
		icon.modulate = red


func update_color_enemies(amount : int, label: Label, icon : TextureRect):
	if amount > 0:
		label.modulate = green
		icon.modulate = red
	else: 
		label.modulate = red
		icon.modulate = green
