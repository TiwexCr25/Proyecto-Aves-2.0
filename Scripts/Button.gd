extends TextureButton

enum Mode { ChangeScene, OpenFloatingWindow, CloseFloatingWindow}

@export var SetMode: Mode
@export var Scene: PackedScene
@export var FloatingWindow: Node

func _ready():
	pass

func _pressed():
	match SetMode:
		Mode.ChangeScene:
			GlobalChangeScene.changeScene(Scene)
		Mode.OpenFloatingWindow:
			FloatingWindow.scale = Vector2.ZERO
			FloatingWindow.visible = true
			var tween = create_tween()
			tween.tween_property(FloatingWindow,"scale",Vector2.ONE,0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		Mode.CloseFloatingWindow:
			FloatingWindow.scale = Vector2.ONE
			var tween = create_tween()
			tween.tween_property(FloatingWindow,"scale",Vector2.ZERO,0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
