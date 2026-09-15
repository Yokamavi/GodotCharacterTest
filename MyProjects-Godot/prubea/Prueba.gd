extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Si presionamos la flecha izquierda:
	if Input.is_action_just_pressed("ui_left"):
		print("SE HA PULSADO IZQUIERDA")
	#Si presionamos la flecha derecha:
	if Input.is_action_just_pressed("ui_right"):
		print("SE HA PULSADO DERECHA")
