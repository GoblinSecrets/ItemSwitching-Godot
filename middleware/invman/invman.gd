extends Node3D

var invdex = ["slot 0","slot 1","slot 2","slot 3"]
var invslot = 0
var invcur = [true,true,true,true]

var pmm = 15

@onready var invplayer = $INVPLYR
@onready var tracercast1 = $tracers/hitscan1
@onready var tracercast2 = $tracers/hitscan2

func _ready() -> void:
	print(pmm)

func _process(delta: float) -> void:
	if Input.is_action_just_released("MWU"):
		slotswitch(1)
	if Input.is_action_just_released("MWD"):
		slotswitch(-1)
	if Input.is_action_just_pressed("USE"):
		if tracercast1.is_colliding():
			var target = tracercast1.get_collider()
			if target.is_in_group("usable"):
				print("used")
	 
	
	if invslot == 0:
		slot0()
		$pistol.hide()
		$mele.hide()
	if invslot == 1:
		slot1()
		$pistol.hide()
		$mele.show()
	if invslot == 2:
		slot2()
		$pistol.show()
		$mele.hide()
	if invslot == 3:
		slot3()
		$pistol.hide()
		$mele.hide()

#slot switch
func slotswitch(num1):
	invslot += num1
	if invslot == 4:
		invslot = 0
	if invslot == -1:
		invslot = 3
	if invcur[invslot] == true:
		pass
	elif invcur[invslot] == false:
		slotswitch(num1)
	print(invdex[invslot]) 


#each slot's functions
func slot0():
	pass
func slot1():
	if Input.is_action_pressed("MLB") and !invplayer.is_playing():
		invplayer.play("Slot0")
		if tracercast1.is_colliding():
			var target = tracercast1.get_collider()
			if target.is_in_group("htable"):
				target.health -= 10
func slot2():
	if Input.is_action_pressed("MLB") and !invplayer.is_playing() and pmm > 0:
		invplayer.play("Slot1")
		#pmm -= 1
		#print(pmm)
		if tracercast2.is_colliding():
			var target = tracercast2.get_collider()
			if target.is_in_group("htable"):
				target.health -= 100
				print(target.health)
	elif Input.is_action_pressed("MLB") and !invplayer.is_playing() and !pmm > 1:
		print(pmm)
func slot3():
	pass
