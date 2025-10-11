extends Node

signal BirdLoaded(value:Ave)
signal AllBirdsLoaded()

@export var firstLoadOfTheProgram:bool = true
var loading:bool = false

var current_index:int = 0

var routes_to_load: Array[String] = []
var lista_aves_totales: Array[Ave] = []

func _ready():
	if firstLoadOfTheProgram == false:
		copy_to_user()
	get_routes()

func copy_to_user():
	var origin = "res://Resources/Birds/"
	var destination = "user://Birds/"
	recursive_copy(origin, destination)

func recursive_copy(origin: String, destination: String):
	var dir = DirAccess.open(origin)
	if dir == null:
		push_error("No se pudo abrir la carpeta: " + origin)
		return
	# Crear carpeta destino si no existe
	if not DirAccess.dir_exists_absolute(destination):
		DirAccess.make_dir_recursive_absolute(destination)

	dir.list_dir_begin()
	while true:
		var nameFile = dir.get_next()
		if nameFile == "":
			break
		if nameFile.begins_with("."):
			continue
		var origin_route = origin + nameFile
		var destination_route = destination + nameFile
		if dir.current_is_dir():
			# Si es carpeta, entrar recursivamente
			recursive_copy(origin_route + "/", destination_route + "/")
		else:
			# Si es archivo, copiar
			var archivo_origen = FileAccess.open(origin_route, FileAccess.READ)
			if archivo_origen == null:
				print("No se pudo leer: ", origin_route)
				continue
			var bytes = archivo_origen.get_buffer(archivo_origen.get_length())
			archivo_origen.close()
			var archivo_destino = FileAccess.open(destination_route, FileAccess.WRITE)
			if archivo_destino == null:
				print("No se pudo escribir: ", destination_route)
				continue
			archivo_destino.store_buffer(bytes)
			archivo_destino.close()
			print("Copiado: ", origin_route, " -> ", destination_route)
	dir.list_dir_end()

func _process(_delta):
	if loading and current_index < routes_to_load.size():
		var route = routes_to_load[current_index]
		var ave = ResourceLoader.load(route) as Ave
		BirdLoaded.emit(ave)
		if ave != null:
			lista_aves_totales.append(ave)
		else:
			print("No se pudo cargar: ", route)
		current_index += 1
	elif loading and current_index >= routes_to_load.size():
		loading = false
		AllBirdsLoaded.emit()
		print("Todas las aves cargadas")
		firstLoadOfTheProgram = true

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

func get_routes():
	routes_to_load.clear()
	var dir = DirAccess.open("user://Birds/")
	if dir == null:
		push_error("No se pudo abrir el directorio user://aves/")
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
		var ruta = "user://Birds/%d.tres" % i
		routes_to_load.append(ruta)
