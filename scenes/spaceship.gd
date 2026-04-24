extends RigidBody2D

# Wie stark der Schub vorwärts/rückwärts ist
var schubkraft = 300.0
# Wie stark das Raumschiff dreht
var drehmomen = 5.0

const Bullet = preload("res://scenes/shoot.tscn")

func _physics_process(delta):
	
	# Drehung 
	if Input.is_action_pressed("drehen_links"):
		apply_torque(-drehmomen)
		
	if Input.is_action_pressed("drehen_rechts"):
		apply_torque(drehmomen)
		
	# Schub 
	# transform.basis_xform(Vector2.UP) gibt die
	# 'vorwärts'-Richtung des rotierten Raumschiffs
	var richtung = transform.basis_xform(Vector2.UP)
	if Input.is_action_pressed("schub_vor"):
		apply_force(richtung * schubkraft)
		$exhaust.visible = true		
	else:
		$exhaust.visible = false
	if Input.is_action_pressed("schub_zurueck"):
		apply_force(-richtung * schubkraft * 0.5)
		
	# Schießen
	if Input.is_action_just_pressed("shoot"):
		shooting()

func shooting():
	var b = Bullet.instantiate()
	owner.add_child(b) #owner hängt den Schuss unter dem Root-Node ein
	b.transform = $Kanone.global_transform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
