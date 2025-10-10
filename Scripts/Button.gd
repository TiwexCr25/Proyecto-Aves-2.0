extends TextureButton

enum Mode { ChangeScene, OpenFloatingWindow, CloseFloatingWindow, CloseGame, Function}

@export var SetMode: Mode
@export var ScenePath: String
@export var FloatingWindow: Node
@export var FunctionString: String

func _ready():
	pass

func _pressed():
	GlobalAudio.ClickSound.play()
	match SetMode:
		Mode.ChangeScene:
			GlobalChangeScene.changeScene(ScenePath)
		Mode.OpenFloatingWindow:
			FloatingWindow.scale = Vector2.ZERO
			FloatingWindow.visible = true
			var tween = create_tween()
			tween.tween_property(FloatingWindow,"scale",Vector2.ONE,0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		Mode.CloseFloatingWindow:
			FloatingWindow.scale = Vector2.ONE
			var tween = create_tween()
			tween.tween_property(FloatingWindow,"scale",Vector2.ZERO,0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		Mode.CloseGame:
			get_tree().quit()
		Mode.Function:
			GlobalSignals.emit_signal("ButtonPressed",FunctionString)
