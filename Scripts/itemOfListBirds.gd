extends TextureButton

var ancho_anterior: float = 0

func _ready():
	_ajustar_altura()

func _process(_delta):
	if size.x != ancho_anterior:
		_ajustar_altura()

func _ajustar_altura():
	ancho_anterior = size.x
	custom_minimum_size.y = size.x
