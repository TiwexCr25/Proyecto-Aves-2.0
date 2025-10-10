@tool
extends GridContainer

var lista_aves: Array[Ave] = []

@export var spinBoxColumns: SpinBox
var _prev_columns: int

@export var FloatingWindow: Node
@onready var button: PackedScene = preload("res://PreScene/itemButtonBird.tscn")

func _ready():
	GlobalAves.cargarTodo()
	lista_aves = GlobalAves.lista_aves_totales
	update_buttons()
	if spinBoxColumns:
		spinBoxColumns.connect("value_changed", Callable(self, "change_columns"))

func _process(_delta):
	if columns != _prev_columns:
		_on_columns_changed()
		_prev_columns = columns

func update_buttons():
	FloatingWindow.lista_aves = lista_aves
	for hijo in get_children():
		hijo.queue_free()
	for ave in lista_aves:
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
