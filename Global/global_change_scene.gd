extends Node

func changeScene(scenePath: String):
	if scenePath != "":
		get_tree().change_scene_to_file(scenePath)
	else:
		push_error("La escena que se intenga cambiar no existe o es nulo")
