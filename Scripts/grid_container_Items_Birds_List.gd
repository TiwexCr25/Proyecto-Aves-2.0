@tool
extends GridContainer

@export var spinBoxColumns: SpinBox
var _prev_columns: int

func _ready():
	if spinBoxColumns:
		spinBoxColumns.connect("value_changed", Callable(self, "changeColumns"))

func _process(_delta):
	if columns != _prev_columns:
		_on_columns_changed()
		_prev_columns = columns

func _on_columns_changed():
	for child in get_children():
		child.custom_minimum_size.y = child.size.x

func changeColumns(value: float) -> void:
	columns = int(value)
