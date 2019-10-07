extends Node

func _ready():
	$Fade.fade_in()
#	$Jeremias.enable_pistola()
	$Fade/Timer.connect("timeout", self, "comecar")
	$Metralheiro/BulletSpawner/Timer.start()

func comecar():
	$Jeremias.can_move = true
	$Metralheiro.connect("morri", self, "finalizar")
	$Jeremias.connect("morri", self, "recomecar")

func finalizar():
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "next_level")
	$Fade.fade_out()

func recomecar():
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "same_level")
	$Fade.fade_out()

func next_level():
	get_tree().change_scene("res://Levels/Level3.tscn")

func same_level():
	get_tree().change_scene("res://Levels/Level2.tscn")