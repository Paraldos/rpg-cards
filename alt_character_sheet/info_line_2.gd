@tool
extends Control

@onready var label_2: Label = $Label2

@export var label_txt: String = "":
	set(value):
		label_txt = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		return
	label_2.text = label_txt
