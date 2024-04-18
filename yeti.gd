extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("angry")
		AudioManager.play("res://sounds/cursing.mp3")
		LevelManager.SIG_BUBBLE.emit("HE !!!", position)
