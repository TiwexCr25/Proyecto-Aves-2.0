extends CanvasLayer

@onready var textLoading = $MarginContainer/PanelContainer/MarginContainer/textLoading
@onready var textContainer = $MarginContainer

func _ready():
	# De momento no es necesario esta parte ------
	#print("antes")
	#await GlobalAves._ready()
	#print("despues")
	# --------------------------------------------
	GlobalAves.cargarTodo()
	GlobalSignals.connect("BirdLoaded",Callable(self,"birdLoaded"))
	GlobalSignals.connect("AllBirdsLoaded",Callable(self,"all_loaded"))

func birdLoaded(_ave: Ave):
	textLoading.text = "Cargando Datos " + str(GlobalAves.current_index + 1) + " de " + str(GlobalAves.routes_to_load.size())

func all_loaded():
	textContainer.visible = false
