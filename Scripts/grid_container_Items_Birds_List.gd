@tool
extends GridContainer

@export var spinBoxColumns: SpinBox
@export var textLoading: Label
@export var currentBirdLoaded: int = 0
#@export var maxBirds: int
var _prev_columns: int

@export var FloatingWindow: Node
@onready var button: PackedScene = preload("res://PreScene/itemButtonBird.tscn")

func _ready():
	#maxBirds = GlobalAves.routes_to_load.size()
	#GlobalSignals.connect("BirdLoaded",Callable(self,"update_one_button"))
	GlobalSignals.connect("AllBirdsLoaded",Callable(self,"all_loaded"))
	#GlobalAves.cargarTodo()
	#lista_aves = GlobalAves.lista_aves_totales
	if GlobalAves.AllLoaded: all_loaded()
	if spinBoxColumns:
		spinBoxColumns.connect("value_changed", Callable(self, "change_columns"))

func _process(_delta):
	if columns != _prev_columns:
		_on_columns_changed()
		_prev_columns = columns

func all_loaded():
	textLoading.visible = false
	#lista_aves = GlobalAves.lista_aves_totales.duplicate()
	#FloatingWindow.lista_aves = lista_aves
	update_buttons()
	call_deferred("_on_columns_changed")

#func update_one_button(ave: Ave):
	#currentBirdLoaded += 1
	#textLoading.text = "Cargando todos los datos (" + str(currentBirdLoaded) + "/" + str(maxBirds) + ")"
	#var new_button = button.instantiate()
	#new_button.texture_normal = ave.imagen
	#new_button.pressed.connect(_on_button_pressed.bind(ave))
	#add_child(new_button)

func update_buttons():
	#FloatingWindow.lista_aves = lista_aves
	for hijo in get_children():
		hijo.queue_free()
	for ave in GlobalAves.lista_aves_totales:
		var new_button = button.instantiate()
		new_button.texture_normal = ave.imagen
		new_button.pressed.connect(_on_button_pressed.bind(ave))
		add_child(new_button)

func _on_button_pressed(ave: Ave):
	GlobalAudio.ClickSound.play()
	FloatingWindow.view_bird(ave)
	FloatingWindow.scale = Vector2.ZERO
	FloatingWindow.visible = true
	var tween = create_tween()
	tween.tween_property(FloatingWindow,"scale",Vector2.ONE,0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_columns_changed():
	for child in get_children():
		child.custom_minimum_size.y = child.size.x

func change_columns(value: float) -> void:
	columns = int(value)
