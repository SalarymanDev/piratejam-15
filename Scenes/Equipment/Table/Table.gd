extends StaticBody2D

@onready var audio_component: AudioComponent = $AudioComponent
@onready var store_item_component: StoreItemComponent = $StoreItemComponent
@onready var stored_item_sprite: Sprite2D = $StoredItemSprite

func _on_drop_off_ingredient_event(_ingredient: IngredientResource) -> void:
	audio_component.play()
	stored_item_sprite.texture = _ingredient.texture
	store_item_component.store(_ingredient as IngredientResource)
	

func _on_drop_off_potion_event(_potion: PotionResource) -> void:
	audio_component.play()
	stored_item_sprite.texture = _potion.texture
	store_item_component.store(_potion as PotionResource)


func _on_picked_up_event() -> void:
	audio_component.play()
	stored_item_sprite.texture = null
	store_item_component.dispense()
	
