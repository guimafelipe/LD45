extends Node

var ja_acabou = false

func _ready():
	$Fade.fade_in()
#	$Jeremias.enable_metralhadora()
	$Fade/Timer.connect("timeout", self, "comecar")
	$JustForBullets/Bazookeiro/Timer.start()

func comecar():
	$Jeremias.can_move = true
	$JustForBullets/Bazookeiro.connect("morri", self, "finalizar")
	$Jeremias.connect("morri", self, "recomecar")

func finalizar():
	if ja_acabou:
		return
	ja_acabou = true
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "next_level")
	$Fade.fade_out()

func recomecar():
	if ja_acabou:
		return
	ja_acabou = true
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "same_level")
	$Fade.fade_out()

func next_level():
	get_tree().quit()

func same_level():
	get_tree().change_scene("res://Levels/Level3.tscn")