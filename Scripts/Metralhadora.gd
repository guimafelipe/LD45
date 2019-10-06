extends Node2D

var BulletClass = preload("res://Bullet.tscn")

const COOLDOWN = 1.5
const N_BULLETS_RAJADA = 3
const CD_RAJADA = 0.5

var timer
var timer_rajada

var bullets_shot = 0
var can_shoot = true

var flipped = false

func _ready():
	timer = $Timer
	timer_rajada = $TimerRajada
	
	timer_rajada.set_wait_time(CD_RAJADA)
	timer.set_wait_time(COOLDOWN)

func shoot():
	if can_shoot:
		can_shoot = false
		start_rajada()

func shoot_bullet():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.global_position)
	bullet.set_dir(Vector2(1, 0).rotated(rotation))
	get_node("../..").add_child(bullet)
	#add_child(bullet)

func take_damage():
	queue_free()

func _on_Timer_timeout():
	print("foi")
	bullets_shot = 0
	can_shoot = true

func start_rajada():
	print(bullets_shot)
	if(bullets_shot < N_BULLETS_RAJADA):
		shoot_bullet()
		bullets_shot += 1
		timer_rajada.start()
	else:
		timer.start()

func _on_TimerRajada_timeout():
	start_rajada()

func _process(delta):
	if flipped:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
