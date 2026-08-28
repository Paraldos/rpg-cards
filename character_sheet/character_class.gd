@tool
extends Resource
class_name CharacterClass

@export var title = ""
@export var max_health = 4
@export var img = Texture2D
@export var abilities : Array[Ability]
@export var strength: int = 1
@export var dex: int = 1
@export var charm: int = 1
@export var wits: int = 1

var strength_txt: String:
	get:
		return "Muckis: %s" % strength

var dex_txt: String:
	get:
		return "Tricks: %s" % dex

var charm_txt: String:
	get:
		return "Charm: %s" % charm

var wits_txt: String:
	get:
		return "Köpfchen: %s" % wits
