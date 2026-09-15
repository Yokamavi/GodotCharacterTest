extends CharacterBody2D
var gravedad = true
const SPEED = 400
const JUMP_SPEED = -600
var jumpCont = 3

func _physics_process(delta: float) -> void:
	while Input.is_action_pressed("Shift"):
		SPEED * 2
		
	#Si el personaje no esta en el suelo, la gravedad ace su trabajo
	if not is_on_floor():
		if gravedad: #Si la gravedad cero no esta activada (true)
			velocity = velocity + get_gravity() * delta
		else:  #Si la gravedad cero esta activada (false)
			velocity = velocity + get_gravity() * delta * 0.5
	else:
		jumpCont = 3
	#Movimiento a la Izquierda
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		
	#Movimiento a la Derecha
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	#Personaje quieto
	else:
		velocity.x = 0
		
	#Movimiento de Salto
	if Input.is_action_just_pressed("ui_accept"):
			if jumpCont > 0:
				velocity.y = JUMP_SPEED
				jumpCont = jumpCont - 1
	move_and_slide() #Método necesario para gestionar el movimiento de el personaje
	
		
	#AL presionar E el boolean gravedad cambia de estado
	if Input.is_action_just_pressed("E"):
		if gravedad:
			gravedad = false
		else:
			gravedad = true
