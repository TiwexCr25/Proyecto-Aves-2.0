extends Node

var lista_aves_totales: Array[Ave] = []
var lista_aves: Array[Ave] = []

func cargarTodo():
	lista_aves_totales.clear()
	var dir = DirAccess.open("res://Resources/Birds/")
	if dir == null:
		push_error("No se pudo abrir el directorio res://Resources/Birds/")
		return
	var mayor_num = 0
	dir.list_dir_begin()
	while true:
		var archivo = dir.get_next()
		if archivo == "":
			break
		if archivo.ends_with(".tres") and archivo.is_valid_filename():
			var nombre_sin_ext = archivo.get_basename()
			var numero = nombre_sin_ext.to_int()
			if numero > mayor_num:
				mayor_num = numero
	dir.list_dir_end()
	for i in range(1, mayor_num + 1):
		var ruta = "res://Resources/Birds/%d.tres" % i
		var ave = ResourceLoader.load(ruta)
		if ave != null:
			lista_aves_totales.append(ave)
		else:
			print("No se pudo cargar: ", ruta)
