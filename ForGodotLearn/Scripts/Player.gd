extends CharacterBody2D

var isJumping : bool = false;
var speed : float = 160.0;
var attackCoolDown : float = 0.3;
func HandleLookingDirection():
#	var faceTo : Vector2 = get_viewport().get_mouse_position();
	var faceTo : Vector2 = get_global_mouse_position();
	look_at(faceTo);
	

func Move(deltaTime):
	var moveDir : Vector2 = Input.get_vector("Left", "Right", "Up", "Down");
	
	velocity = moveDir * speed;
	move_and_slide();
	
	

signal snotBall(snotBallPosition, direction);
var coolDownTimer : float = 0.0;

func check_and_attack():
	if (Input.is_action_pressed("Attack")):
		var snotSpawnPositionArray = $SnotSpawnPosition.get_children();
		var selectedSpawnPosition = snotSpawnPositionArray[randi() % $SnotSpawnPosition.get_child_count()];
		
		var direction : Vector2 = (get_global_mouse_position() - global_position).normalized();
		
		snotBall.emit(selectedSpawnPosition.global_position, direction);
		
		coolDownTimer = 0.0;


func HandleBehaviour(): 
	coolDownTimer += get_process_delta_time();
	
	if (coolDownTimer >= attackCoolDown):
		check_and_attack();
	
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Move(delta);
	HandleBehaviour();
	HandleLookingDirection();
	pass
	
