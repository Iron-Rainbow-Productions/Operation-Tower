extends Node2D
@export var table_res:TableVariant__res
@export var deck_res:CardVariant__res
@onready var table_case = $Table_case
@onready var bank_case = $Bank_Case


var TOWER = preload("res://Assets/Nodes/Util/tower.tscn")
var tower:Tower

@onready var table = $BackDrop/Table

func _ready():
	build_game()
	tower.animation_player.play("Entry")



func build_game():
	table.table__res = table_res
	table.build_table()
	tower = TOWER.instantiate()
	add_child(tower)
	tower.card_res = deck_res
	tower.build_tower()
	tower.scale = Vector2(.09,.09)
	tower.position = Vector2(175,350)
	
	bank_case.populate(0)
	table_case.populate(1)
	
