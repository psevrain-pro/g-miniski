extends Node2D

@export var nb_portes: int = 0
var portes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	count_down_and_start()
	LevelManager.SIG_PORTE.connect(on_porte)
	LevelManager.SIG_FINISH.connect(on_finish)
	
func count_down_and_start():
	await get_tree().create_timer(1.0).timeout
	AudioManager.play("res://sounds/ski_depart.mp3")
	await get_tree().create_timer(1.45).timeout
	LevelManager.SIG_START.emit()

func on_porte():
	portes += 1
	AudioManager.play("res://sounds/tic.wav")

func on_finish(where):
	print("Portes %d"%portes)
