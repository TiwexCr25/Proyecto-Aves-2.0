extends Node

signal ButtonPressed(value: String)

func N():
	ButtonPressed.emit()
