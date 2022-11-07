pushpc
org $00E31A|!bank
    autoclean jml custom_palettes

org $00E30C|!bank
    autoclean jml custom_palettes_star

org $00E326|!bank
    custom_palettes_return:
pullpc

reset bytes

custom_palettes:
    lda !player_palette_bypass
    bne .bypass
.regular_colors
    rep #$20
    lda !player_powerup
    and #$00FF
    ldx !player_num
    beq .p1
    clc 
    adc.w #$03
.p1 
    rep #$10
    tax 
    sep #$20
    lda.l custom_palettes_indexes,x
    cmp #$FF
    bne +
    lda !player_graphics_index
+   
    sta !player_palette_index
.bypass
    rep #$30
    lda !player_palette_index
    and #$00FF
    sta $00
    asl 
    clc 
    adc $00
    tax
    lda.l custom_palettes_pointers,x
    sta !player_palette_pointer
    lda.l custom_palettes_pointers+1,x
.end
    sta !player_palette_pointer+1
    sep #$30
    jml custom_palettes_return

.star
    ldx $149B|!addr
    bne .pal_anim
    and.b #!palette_star_animation_frames
    sta $00
    asl 
    clc 
    adc $00
    tax
    rep #$20
    lda.l custom_star_palettes_pointers,x
    sta !player_palette_pointer
    lda.l custom_star_palettes_pointers+1,x
    bra .end

.pal_anim
    and.b #!palette_animation_frames
    sta $00
    asl 
    clc 
    adc $00
    tax
    rep #$20
    lda.l custom_palette_animation_pointers,x
    sta !player_palette_pointer
    lda.l custom_palette_animation_pointers+1,x
    bra .end


custom_palettes_pointers:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dl custom_palettes_data
        else
            if !{gfx_!{_num}_palette_exist} == 1
                dl gfx_!{_num}_palette
            else
                dl custom_palettes_data
            endif
        endif
        !i #= !i+1
    endif

custom_palettes_data:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_palette_exist} == 1
                gfx_!{_num}_palette:
                    incbin "../player_graphics/!{gfx_!{_num}_internal_name}/!{gfx_!{_num}_internal_name}.mw3":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
            endif
        endif
        !i #= !i+1
    endif

custom_palettes_indexes:
.player_1
    db !small_p1_pal_num
    db !big_p1_pal_num
    db !cape_p1_pal_num
    db !fire_p1_pal_num
.player_2
    db !small_p2_pal_num
    db !big_p2_pal_num
    db !cape_p2_pal_num
    db !fire_p2_pal_num

custom_palette_animation_pointers:
    !i #= 0
    while !i < !palette_animation_frames+1
        %internal_number_to_string(!i)
        dl palette_animation_frame_!{_num}
        !i #= !i+1
    endif

    !i #= 0
    while !i < !palette_animation_frames+1
        %internal_number_to_string(!i)
        palette_animation_frame_!{_num}:
            incbin "../player_graphics/palette_animation/frame_!{_num}.mw3":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
        !i #= !i+1
    endif



custom_star_palettes_pointers:
    !i #= 0
    while !i < !palette_animation_frames+1
        %internal_number_to_string(!i)
        dl star_palette_frame_!{_num}
        !i #= !i+1
    endif

    !i #= 0
    while !i < !palette_animation_frames+1
        %internal_number_to_string(!i)
        star_palette_frame_!{_num}:
            incbin "../player_graphics/palette_animation/frame_!{_num}.mw3":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
        !i #= !i+1
    endif