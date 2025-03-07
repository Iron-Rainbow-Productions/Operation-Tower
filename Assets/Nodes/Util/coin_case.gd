extends StaticBody2D

@onready var marker_2d = $Marker2D
var COIN = preload("res://Assets/Nodes/Util/coin.tscn")
var target

@onready var million_coins =[]
@onready var hunthou_coins =[]
@onready var man_coins =[]
@onready var thou_coins =[]
@onready var hunnie_coins =[]
@onready var fiddy_coins =[]
@onready var single_coins =[]

@onready var coin_collection:Array = [million_coins, hunthou_coins,man_coins,thou_coins,
								hunnie_coins,fiddy_coins,single_coins]

func create_coin(denomination:String, address):
	var coin:Coin = COIN.instantiate()
	add_child(coin)
	coin.collision_mask = self.collision_mask
	coin.collision_layer = self.collision_layer
	coin.modulate = Banker.coin_dictionary[denomination]
	coin.position = marker_2d.position + Vector2(randf_range(-10,10),0)
	
	coin_collection[address].append(coin)

func populate(case):
	var coins = Banker.account(case)
	var denominations = ["Million","Hunthousand","Man","Thousand",
						"Hundred","Fifty", "One"]
	
	var x = 0
	var y = 0
	
	for coin in coins:
		x = 0
		while x < coin:
			await get_tree().create_timer(.15).timeout
			create_coin(denominations[y], y)
			x += 1
		y += 1
	assign_value()

func assign_value():
	var x = 0
	for array in coin_collection:
		x += 1
		for coin:Coin in array:
			match x:
				1:
					coin.value = 1000000
				2:
					coin.value = 100000
				3:
					coin.value = 10000
				4:
					coin.value = 1000
				5:
					coin.value = 100
				6:
					coin.value = 50
				7:
					coin.value = 1
