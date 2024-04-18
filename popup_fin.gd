extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	LevelManager.SIG_FINISH.connect(on_finish)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and visible :
		get_tree().reload_current_scene()

func on_finish(where):
	var penalites = get_node("/root/Game").nb_portes - get_node("/root/Game").portes
	var chrono = get_node("/root/Game/GUI/chrono").total
	$penalites.text = "Malus : %d porte(s)\n +%ds" %[penalites,penalites]
	$final.text = "Final : %5.2fs" %(chrono+penalites)
	visible = true
	AudioManager.play("res://sounds/results.mp3")
	await get_tree().create_timer(1.0).timeout
