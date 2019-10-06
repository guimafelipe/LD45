extends KinematicBody2D

signal morri

func take_damage():
	emit_signal("morri")
	queue_free()