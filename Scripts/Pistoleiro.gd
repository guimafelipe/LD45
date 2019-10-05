extends KinematicBody2D

var BulletClass = preload("res://Bullet.tscn")

const COOLDOWN = 1.5

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func shoot():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(-1, 0))
	add_child(bullet)
	pass


func _on_Timer_timeout():
	shoot()
