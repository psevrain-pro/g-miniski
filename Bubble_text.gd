extends Label

var move = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(texte: String):
	text = texte
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += move * delta


func _on_timer_timeout():
	queue_free()
