extends Node

signal SIG_BUBBLE(msg, where)
signal SIG_FINISH(where)
signal SIG_JUMP(where)
signal SIG_START()
signal SIG_PORTE()

var scene_bubble_text = preload("res://bubble_text.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SIG_BUBBLE.connect(on_bubble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_bubble(msg, where):
	var b = scene_bubble_text.instantiate()
	b.init(msg)
	get_node("/root/Game").add_child(b)
	b.position = where
	
