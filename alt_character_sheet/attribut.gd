@tool
extends HBoxContainer

@onready var label: Label = $Label
@export var label_txt: String = "":
	set(value):
		label_txt = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		return
	label.text = label_txt
