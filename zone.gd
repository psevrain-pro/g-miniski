extends Area2D

var active = true
@export var msg: String

enum CATEGORY_ZONE {PORTE, MSG, FINISH, JUMP}
@export var categorie: CATEGORY_ZONE = CATEGORY_ZONE.MSG

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name=="Player":
		if active : 
			active = false
			if categorie == CATEGORY_ZONE.MSG:
				LevelManager.SIG_BUBBLE.emit(msg, position)
			elif categorie == CATEGORY_ZONE.PORTE:
				LevelManager.SIG_PORTE.emit()
			elif categorie == CATEGORY_ZONE.FINISH:
				LevelManager.SIG_FINISH.emit(position)
			elif categorie == CATEGORY_ZONE.JUMP:
				LevelManager.SIG_JUMP.emit(position)
