extends KinematicBody2D

var BulletClass = preload("res://Missil.tscn")

const COOLDOWN = 3

var vidas = 4

signal morri

func _ready():
	$Timer.set_wait_time(COOLDOWN)

func shoot():
	var bullet = BulletClass.instance()
#	bullet.positon = $BulletSpawner.position
	bullet.set_position($BulletSpawner.global_position)
	bullet.set_dir(Vector2(1, 0).normalized())
	get_parent().add_child(bullet)

func _on_Timer_timeout():
	shoot()

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