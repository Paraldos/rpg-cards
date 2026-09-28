@tool
extends PanelContainer

@onready var center: ColorRect = $Center
@export var on := false:
	set(value):
		on = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		return
	center.visible = on
