extends Node2D

const BulletClass = preload("res://Bullet.tscn")
const COOLDOWN = 1

var can_shoot = true
var flipped = false

var shoot_direction = Vector2(1,0)

func _ready():
	$Timer.set_wait_time(COOLDOWN)

func shoot():
	if not can_shoot:
		return
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.global_position)
	bullet.set_dir(shoot_direction.rotated(rotation))
	get_parent().get_parent().add_child(bullet)
	can_shoot = false
	$Timer.start()


func _on_Timer_timeout():
	can_shoot = true

func _process(delta):
	if flipped:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false