@tool
extends PanelContainer

@onready var title: Label = %Title
@onready var img: TextureRect = %Img
@onready var ability_display: PanelContainer = %AbilityDisplay
@onready var skill: Label = %Skill

@export var card : Card:
	set(value):
		card = value
		_update()

@export_tool_button("Update", "Reload")
var update_button = _update

func _ready() -> void:
	_update()

func _update():
	if not is_node_ready():
		await ready
	if card == null:
		title.text = ""
		img.texture = null
		ability_display.ability = null
		skill = null
	else:
		title.text = card.title
		img.texture = card.img
		ability_display.ability = card.ability
		skill.text = Skills.get_skill_name(card.skill)
