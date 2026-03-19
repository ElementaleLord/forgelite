extends CanvasLayer

@onready var inventory_sub: BoxContainer = $TextureRect/HBoxContainer/InventoryTexture/InventorySub
@onready var target_score: ProgressBar = %TargetScore
@onready var forging_bar: ProgressBar = %ForgingBar
@onready var quality_score: ProgressBar = %QualityScore

@onready var magenta_hit: Button = %MagentaHit
@onready var cyan_hit: Button = %CyanHit
@onready var yellow_hit: Button = %YellowHit
@onready var darkgray_hit: Button = %DarkgrayHit
@onready var lightgray_hit: Button = %LightgrayHit
@onready var red_hit: Button = %RedHit
@onready var blue_hit: Button = %BlueHit
@onready var green_hit: Button = %GreenHit

@onready var first_last_hit: TextureRect = %FirstLastHit
@onready var second_last_hit: TextureRect = %SecondLastHit
@onready var third_last_hit: TextureRect = %ThirdLastHit
@onready var first_pattern_hit: TextureRect = %FirstPatternHit
@onready var second_pattern_hit: TextureRect = %SecondPatternHit
@onready var third_pattern_hit: TextureRect = %ThirdPatternHit

@export_category("ScoreVars")
@export_range(50,500,50) var max_score= 100
@export_range(0,50,5) var min_score= 0
@export_category("HitIncrements")
@export_range(-20,-10,1) var magenta_increment: int= -15
@export_range(-15,-5,1) var cyan_increment: int= -10
@export_range(-10,0,1) var yellow_increment: int= -5
@export_range(-5,5,1) var darkgray_increment: int= -1
@export_range(-5,5,1) var lightgray_increment: int= 1
@export_range(0,10,1) var red_increment: int= 5
@export_range(5,15,1) var blue_increment: int= 10
@export_range(10,20,1) var green_increment: int= 15
@export_category("HitColors")
@export var magenta_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-magentaPattern.png")
@export var cyan_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-cyanPattern.png")
@export var yellow_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-yellowPattern.png")
@export var darkgray_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-darkgrayPattern.png")
@export var lightgray_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-lightgrayPattern.png")
@export var red_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-redPattern.png")
@export var blue_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-bluePattern.png")
@export var green_pattern: CompressedTexture2D= preload("res://Assets/HitPattern/ForgeLite-greenPattern.png")

var pattern_to_increment: Dictionary[CompressedTexture2D, int]={
	magenta_pattern: magenta_increment,
	cyan_pattern: cyan_increment,
	yellow_pattern: yellow_increment,
	darkgray_pattern: darkgray_increment,
	lightgray_pattern: lightgray_increment,
	red_pattern: red_increment,
	blue_pattern: blue_increment,
	green_pattern: green_increment
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# forging bar calibration
	forging_bar.min_value= min_score
	forging_bar.max_value= max_score
	forging_bar.value= min_score
	
	# dynamic pattern set up
	magenta_hit.icon= magenta_pattern
	cyan_hit.icon= cyan_pattern
	yellow_hit.icon= yellow_pattern
	darkgray_hit.icon= darkgray_pattern
	lightgray_hit.icon= lightgray_pattern
	red_hit.icon= red_pattern
	blue_hit.icon= blue_pattern
	green_hit.icon= green_pattern
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (forging_bar.value < forging_bar.min_value or
		forging_bar.value > forging_bar.max_value):
		# if i exceed bounds item breaks
		forging_bar.value= forging_bar.min_value
	pass


func _on_hit_pressed(hit_path: NodePath) -> void:
	var btn: Button= get_node_or_null(hit_path)
	if btn:
		var btn_icon: CompressedTexture2D= btn.icon
		if btn_icon in pattern_to_increment:
			forging_bar.value+= pattern_to_increment[btn_icon]
			color_switch(btn_icon)
	pass


func color_switch(new_Pattern: CompressedTexture2D):
	third_last_hit.texture= second_last_hit.texture
	second_last_hit.texture= first_last_hit.texture
	first_last_hit.texture= new_Pattern
	pass
