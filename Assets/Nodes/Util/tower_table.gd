extends Node2D
@export var table_res:TableVariant__res
@export var deck_res:CardVariant__res


var TOWER = preload("res://Assets/Nodes/Util/tower.tscn")
var tower:Tower

@onready var table = $BackDrop/Table

func _ready():
	build_game()



func build_game():
	table.table__res = table_res
	table.build_table()
	tower = TOWER.instantiate()
	add_child(tower)
	tower.card_res = deck_res
	tower.build_tower()
	tower.scale = Vector2(.09,.09)
	tower.position = Vector2(175,350)
	
