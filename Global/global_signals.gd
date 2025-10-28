extends Node

signal ButtonPressed(value: String)
signal BirdLoaded(value:Ave)
signal AllBirdsLoaded()

func N():
	ButtonPressed.emit()
	BirdLoaded.emit(null)
	AllBirdsLoaded.emit()
