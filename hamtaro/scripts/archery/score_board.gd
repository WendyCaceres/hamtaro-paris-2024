extends ColorRect
@onready var label_1 = $MarginContainer2/VBoxContainer/score_1
@onready var label_2 = $MarginContainer2/VBoxContainer/score_2
@onready var label_3 = $MarginContainer2/VBoxContainer/score_3

var score_1 = 0
var score_2 = 0
var score_3 = 0
var total_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func sum_score():
	total_score =  score_1 + score_2 + score_3
# Called every frame. 'delta' is the elapsed time since the previous frame.

func change_score():
	label_1.text = str(score_1)
	label_2.text = str(score_2)
	label_3.text = str(score_3)
	
func _process(delta):
	change_score()
