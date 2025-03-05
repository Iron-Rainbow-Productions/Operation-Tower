extends TextureRect
class_name Table

@export var table__res:TableVariant__res

@onready var background = $background
@onready var tablerim = $tablerim
@onready var felttexture = $felttexture

func _ready():
	build_table()


func build_table():
	self.texture = table__res.backcolor
	background.texture = table__res.backtexture
	tablerim.texture = table__res.tableback
	felttexture.texture = table__res.tablefelt
