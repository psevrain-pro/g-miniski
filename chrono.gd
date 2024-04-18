extends Label

var total = 0

func _ready():
	LevelManager.SIG_START.connect(on_start)
	LevelManager.SIG_FINISH.connect(on_finish)

func _on_timer_timeout():
	total += 0.05
	text = "%5.2f s" %total

func on_start():
	$Timer.start()

func on_finish(where):
	$Timer.stop()
