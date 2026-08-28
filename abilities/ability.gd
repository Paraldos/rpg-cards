@tool
extends Resource
class_name Ability

enum Cost {
	PASSIVE,
	EXHAUST_THIS_CARD,
	EXHAUST_ANY_CARD
}

const COST_TEXTS := {
	Cost.PASSIVE: "Passiv",
	Cost.EXHAUST_THIS_CARD: "Erschöpfe diese Karte",
	Cost.EXHAUST_ANY_CARD: "Erschöpfe irgendeine Karte"
}

@export var title := ""
@export var cost: Cost = Cost.PASSIVE
@export_multiline var description := ""

func get_cost_text() -> String:
	return COST_TEXTS[cost]
