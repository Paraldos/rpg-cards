@tool
extends PanelContainer

@onready var title: Label = %Title
@onready var img: TextureRect = %Img
@onready var abilities_container: VBoxContainer = %AbilitiesContainer
@onready var heartcontainer: HBoxContainer = %Heartcontainer
@onready var strength: Label = %Strength
@onready var dex: Label = %Dex
@onready var charm: Label = %Charm
@onready var wits: Label = %Wits

const HEART = preload("uid://446umbmhdpke")
const ABILITY_DISPLAY = preload("uid://b786uabnbl0m2")

@export var character_class: CharacterClass:
	set(value):
		character_class = value
		_update()

@export_tool_button("Update", "Reload")
var update_button = _update

func _update():
	if not is_node_ready():
		await ready
	_clean_container(abilities_container)
	_clean_container(heartcontainer)
	if character_class == null:
		title.text = ""
		img.texture = null
		strength.text = "?"
		dex.text = "?"
		charm.text = "?"
		wits.text = "?"
	else:
		title.text = character_class.title
		img.texture = character_class.img
		strength.text = character_class.strength_txt
		dex.text = character_class.dex_txt
		charm.text = character_class.charm_txt
		wits.text = character_class.wits_txt
		_add_hearts()
		_add_abilities()

func _clean_container(container):
	for child in container.get_children():
		child.queue_free()

func _add_hearts():
	for i in character_class.max_health:
		var h = HEART.instantiate()
		heartcontainer.add_child(h)

func _add_abilities():
	for ability in character_class.abilities:
		if ability is not Ability: continue
		var display = ABILITY_DISPLAY.instantiate()
		abilities_container.add_child(display)
		display.ability = ability
