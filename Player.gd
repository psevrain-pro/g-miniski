extends CharacterBody2D
var acceleration = 0.01
var vitesse_max = 100
var LR_SPEED = 70.0
var vitesse = 10
var freinage = 0.35

var mode = "WAIT"

@onready var tilemap = get_node("/root/Game/Neige")

func _ready():
	LevelManager.SIG_START.connect(start)
	LevelManager.SIG_FINISH.connect(on_finish)
	LevelManager.SIG_JUMP.connect(on_jump)

func _physics_process(delta):

	if mode == "SKI" or mode == "JUMP":
		vitesse_max = get_custom_data_at(position, "MAX_SPEED") if mode =="SKI" else 200
		vitesse += (vitesse_max - vitesse) * acceleration
		vitesse = clamp(vitesse,1,200)
		
		acceleration = 0.01
		if mode == "SKI":
			if Input.is_action_just_pressed("ui_accept") and vitesse <= 190 and $timer_pousse.is_stopped():
				$timer_pousse.start()
				#vitesse += 10
				acceleration = 0.6
				$AnimatedSprite2D.play("pousse")
			elif Input.is_action_just_pressed("ui_cancel"):
				get_tree().reload_current_scene()
			
			var direction = Input.get_axis("ui_left", "ui_right")
			if direction:
				#rotation_degrees = -20 * direction
				#vitesse -= freinage
				rotation_degrees += -1 * direction
				vitesse -= abs(rotation_degrees / 35)
			else:
				#rotation_degrees = 0
				pass
			AudioManager.module_ski(vitesse/2-50)
			
		velocity = transform.y * vitesse
		var collisions = move_and_slide()
		if collisions:
			vitesse -= 2
		

func start():
	mode = "SKI"
	AudioManager.play_ski()

func on_finish(where):
	AudioManager.play("res://sounds/clapping.wav")
	await get_tree().create_timer(0.5).timeout
	mode = "FIN"
	AudioManager.stop_ski()
	
func on_jump(where):
	if vitesse > 60:
		$timer_jump.start(vitesse/200)
		AudioManager.module_ski(0)
		mode = "JUMP"
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.scale = Vector2.ONE * (vitesse * 0.0125 + 0.35)

func _on_fin_jump():
	mode = "SKI"
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.scale = Vector2.ONE

func get_tile_data_at(where: Vector2) -> TileData:
	var local_position: Vector2 = tilemap.local_to_map(where)
	return tilemap.get_cell_tile_data(0, local_position)


func get_custom_data_at(where: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(where)
	if data != null :
		return data.get_custom_data(custom_data_name)
	else : 
		return 100

