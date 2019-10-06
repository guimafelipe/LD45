extends TextureRect

const FADE_TIME = 2
var target = 1
var a = 0

func fade_in():
	a = 1
	target = 0
	$Timer.start()

func fade_out():
	a = 0
	target = 1
	$Timer.start()

func _process(delta):
	if target == 1:
		a = (FADE_TIME - $Timer.time_left)/FADE_TIME
	else:
		a = $Timer.time_left/FADE_TIME
	modulate = Color(0,0,0,a)

func _ready():
	$Timer.set_wait_time(FADE_TIME)