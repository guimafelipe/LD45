extends KinematicBody2D

var BulletClass = preload("res://Bullet.tscn")

const COOLDOWN = 1.5

signal morri

var vidas = 2

func shoot():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(-1, 0))
	add_child(bullet)

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