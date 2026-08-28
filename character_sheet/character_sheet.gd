@tool
extends PanelContainer

@onready var title: Label = %Title
@onready var img: TextureRect = %Img

@export var character_class : CharacterClass

func _update():
	if character_class is not CharacterClass: return
	title.text = character_class.title
	img.texture = character_class.img
