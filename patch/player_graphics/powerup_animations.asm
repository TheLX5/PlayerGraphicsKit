;##############################################################################
;# Per-powerup animations
;# In this place you can put code to handle extra movements that aren't
;# handled by the default animation routine.
;# Note that the animations/poses you put here must have valid graphics to be properly shown

small_animations:
    rts

big_animations:
    rts

cape_animations:
    lda #$81
    sta !player_extra_tile_settings
    rts 

fire_animations:
    rts 