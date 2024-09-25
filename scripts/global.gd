extends Node

var turn
var entities = {
	'monsters': [],
	'adv': []
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn = 'prepare'
