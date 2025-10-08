extends Node

func changeScene(scene: PackedScene):
	if scene != null:
		get_tree().change_scene_to_packed(scene)
	else:
		push_error("La escena que se intenga cambiar no existe o es nulo")
