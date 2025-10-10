extends NinePatchRect

var lista_aves: Array[Ave] = []
var ave: Ave

@onready var cientific_name = %inputCiN
@onready var common_name = %inputCoN
@onready var family = %inputF
@onready var image = %inputImage
@onready var player = AudioStreamPlayer.new()
#@onready var line:ColorRect = %line
@onready var sonogram:TextureButton = %inputSonogram

@onready var backButton: TextureButton = %BackButton
@onready var nextButton: TextureButton = %NextButton

func _ready():
	GlobalSignals.ButtonPressed.connect(_on_boton_button_pressed)
	add_child(player)

func _on_boton_button_pressed(value: String):
	if lista_aves.is_empty():
		return
	var index = lista_aves.find(ave)
	if index == -1:
		index = 0
	if value == "back" and index > 0:
		index -= 1
	elif value == "next" and index < lista_aves.size() - 1:
		index += 1
	view_bird(lista_aves[index])
	if index == 0:
		backButton.disabled = true
		backButton.self_modulate.a = 0.5
	else:
		backButton.disabled = false
		backButton.self_modulate.a = 1
	
	if index == lista_aves.size() - 1:
		nextButton.disabled = true
		nextButton.self_modulate.a = 0.5
	else:
		nextButton.disabled = false
		nextButton.self_modulate.a = 1

func view_bird(bird_ref: Ave):
	ave = bird_ref
	image.texture = ave.imagen
	cientific_name.text = ave.nombre_cientifico
	common_name.text = ave.nombre_comun
	family.text = ave.familia
	player.stream = ave.sonido
	sonogram.texture_normal = ave.sonograma
