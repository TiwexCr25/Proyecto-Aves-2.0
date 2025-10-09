extends CanvasLayer

@onready var control:Control = $Control

func _ready():
	InScene()
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_resized"))
	_on_viewport_resized()

func InScene():
	scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE,0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_viewport_resized():
	offset = get_viewport().get_visible_rect().size / 2
	control.position = -offset
	#print(offset)
