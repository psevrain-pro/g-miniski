extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vitesse = int(get_node("/root/Game/Player").get_real_velocity().length())
	text = "%d km/h" % vitesse
