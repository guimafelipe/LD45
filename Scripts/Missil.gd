extends Area2D

const SPEED = 180
var velocity = Vector2()
var origin_is_player = false
var player
const ROTATION_SPEED = 0.7
const LIFE_TIME = 8

func _ready():
	$LifeTimer.set_wait_time(LIFE_TIME)
	$LifeTimer.start()
	player = get_node("../../Jeremias")

func set_dir(dir):
	velocity = dir*SPEED

func update_dir(delta):
	if not player:
		return
	var direction = player.global_position - global_position
	var angle = velocity.angle_to(direction)
	if angle > 0:
		velocity = velocity.rotated(ROTATION_SPEED*delta)
	elif angle < 0:
		velocity = velocity.rotated(-ROTATION_SPEED*delta)

func _physics_process(delta):
	update_dir(delta)
	translate(velocity*delta)

func explode():
	for obj in $ExplosionArea.get_overlapping_bodies():
		if obj.has_method("hit"):
			obj.hit()
	# tocar animação de explosão
	queue_free()

func _on_LifeTimer_timeout():
	explode()

func _on_Missil_area_entered(area):
	if area.name == "Bullet":
		explode()


func _on_Missil_body_entered(body):
	explode()
