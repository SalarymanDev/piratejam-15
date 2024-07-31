extends StaticBody2D

@onready var audio_component: AudioComponent = $AudioComponent
@onready var store_item_component: StoreItemComponent = $StoreItemComponent
@onready var stored_item_sprite: Sprite2D = $StoredItemSprite
@onready var click_component: ClickableComponent = $ClickableComponent

func _on_drop_off_ingredient_event(_ingredient: IngredientResource) -> void:
	audio_component.play()
	stored_item_sprite.texture = _ingredient.texture
	click_component.update_tooltip("%s\n%s" % [_ingredient.name, _ingredient.description])
	store_item_component.store(_ingredient as IngredientResource)
	

func _on_drop_off_potion_event(_potion: PotionResource) -> void:
	audio_component.play()
	click_component.update_tooltip(_potion.name)
	stored_item_sprite.texture = _potion.texture
	store_item_component.store(_potion as PotionResource)


func _on_picked_up_event() -> void:
	audio_component.play()
	stored_item_sprite.texture = null
	click_component.update_tooltip("Table")
	store_item_component.dispense()



func _item_swapped_event(new_item: ItemResource) -> void:
	audio_component.play()
	stored_item_sprite.texture = new_item.texture
	click_component.update_tooltip("%s\n%s" % [new_item.name, new_item.description])
	store_item_component.store(new_item)
