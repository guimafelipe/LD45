extends Area2D

onready var PlayerClass = preload("res://Scripts/Jeremias.gd")

func _on_PistolaPickable_body_entered(body):
	if body is PlayerClass:
		body.enable_pistola()
		queue_free()
