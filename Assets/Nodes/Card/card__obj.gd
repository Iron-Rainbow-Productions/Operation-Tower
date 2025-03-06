extends Node2D
class_name Card

signal spare_used


@export var Card_Res:CardVariant__res 

@export var card:int = 0
@export var tower_coordinates = [0,0]
@export var burnt_card = false
@export var heroed = false


@onready var one__bg = $one
@onready var two__bg = $two
@onready var three__bg = $three
@onready var four__bg = $four
@onready var five__bg = $five
@onready var six__bg = $six
@onready var seven__bg = $seven
@onready var hero__bg = $hero
@onready var burn__fg = $burn__fg
@onready var cardback__bg = $CardBack__spr
@onready var placer = $Placer

@onready var burner = $burner
@onready var blaster = $blaster
@onready var animation_player = $AnimationPlayer

@onready var cardstates = [cardback__bg,one__bg,two__bg,
three__bg,four__bg,five__bg,six__bg,
seven__bg,hero__bg,burn__fg]


func _ready():
	burner.emitting = false
	blaster.emitting = false
	
func turn_off():
	for state in cardstates:
		state.visible = false
	cardback__bg.visible = true
	placer.visible = false
	burner.visible = true
	blaster.visible = true
	burner.emitting = false
	blaster.emitting = false

func build_Card():
	one__bg.texture = Card_Res.front
	one__bg.design.texture = Card_Res.one
	two__bg.texture = Card_Res.front
	two__bg.design.texture = Card_Res.two
	three__bg.texture = Card_Res.front
	three__bg.design.texture = Card_Res.three
	four__bg.texture = Card_Res.front
	four__bg.design.texture = Card_Res.four
	five__bg.texture = Card_Res.front
	five__bg.design.texture = Card_Res.five
	six__bg.texture = Card_Res.front
	six__bg.design.texture = Card_Res.six
	seven__bg.texture = Card_Res.sevenfront
	seven__bg.design.texture = Card_Res.seven
	hero__bg.texture = Card_Res.front
	hero__bg.design.texture = Card_Res.hero
	cardback__bg.texture = Card_Res.cardbackbackground
	cardback__bg.design.texture = Card_Res.cardbackbackdesign
	cardback__bg.logo.texture = Card_Res.logo

func deck_ready():
	cardback__bg.texture = Card_Res.cardbackbackground
	cardback__bg.design.texture = Card_Res.cardbackbackdesign
	cardback__bg.logo.texture = Card_Res.logo

func assign_Card(id):
	cardstates[id].visible = true

func flip_Card():
	print(name, "___: Flipped")
	animation_player.play("Card_Flip")

func spare_Card(time_delay):
	await get_tree().create_timer(time_delay).timeout
	animation_player.play("Spare")

func burn():
	if !burnt_card:
		print(name, "___: Burnt")
		animation_player.play("Burn")
		burnt_card = true

func heroism():
	print(name, "___: Heroism")
	animation_player.play("Heroism")
func be_hero():
	if !heroed:
		heroed = true
		print(name, "___: Hero")
		animation_player.play("Hero")

func hide_Card():
	print(name, "___: Hidden")
	if !cardback__bg.visible: 
		animation_player.play("unflip")
	cardstates[card].visible = true

func use_Spare(target_card:Card):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", self.position + Vector2(0,0), .5)
	
	tween.tween_property(self,"position", self.position - Vector2(0,300), .2)
	tween.parallel().tween_property(self,"z_index", 16, 1)
	spare_Card(.5)
	tween.tween_property(self,"position", self.position - Vector2(0,300), 1)

	tween.tween_property(self,"z_index", target_card.z_index,.5)
	tween.parallel().tween_property(self,"position",target_card.position,.5)
	tween.parallel().tween_property(target_card,"z_index",target_card.z_index-1,.5)
	
	spare_used.emit()
	
