extends KinematicBody2D

var BulletClass = preload("res://Bullet.tscn")

const COOLDOWN = 2.5
const N_BULLETS_RAJADA = 3
const CD_RAJADA = 0.08

var timer
var timer_rajada

var bullets_shot = 0

var vidas = 3

signal morri

func _ready():
	timer = $BulletSpawner.get_node("Timer")
	timer_rajada = $BulletSpawner.get_node("TimerRajada")
	
	timer_rajada.set_wait_time(CD_RAJADA)
	timer.set_wait_time(COOLDOWN)
	
	start_fight()

func start_fight():
	timer.start()

func shoot():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(-1, 0))
	add_child(bullet)

func take_damage():
	vidas-=1
	modulate = Color(1, 0.2, 0.2, 0.5)
	$DmgTimer.start()
	if vidas == 0:
		die()

func die():
	emit_signal("morri")
	queue_free()

func _on_DmgTimer_timeout():
	modulate = Color(1,1,1,1)

func _on_Timer_timeout():
	bullets_shot = 0
	start_rajada()

func start_rajada():
	print(bullets_shot)
	if(bullets_shot < N_BULLETS_RAJADA):
		shoot()
		bullets_shot += 1
		timer_rajada.start()
	else:
		timer.start()

func _on_TimerRajada_timeout():
	start_rajada()
