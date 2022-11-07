pushpc
    org $0096B4|!bank
        autoclean jsl init_ram
pullpc

init_ram:
    lda #$00
    sta !player_graphics_bypass
    sta !player_graphics_index
    sta !player_graphics_extra_index
    sta !player_graphics_disp_settings
    sta !player_extra_tile_settings
    sta !player_palette_bypass
    ldx	#$07
    lda	#$FF
    rtl 
