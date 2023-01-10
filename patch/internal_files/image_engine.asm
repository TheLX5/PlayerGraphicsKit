reset bytes

;################################################
;# Hijacks

pushpc
    org $00E36D|!bank
        autoclean jml player_poses_handler
    warnpc $00E3C0|!bank

    org $00E3E4|!bank
        BRA +
    org $00E3EC|!bank
    +


    org $00E489|!bank
        autoclean jsl player_x_disp_handler

    org $00E471|!bank
        autoclean jsl player_y_disp_handler

    org $00E326|!bank
        autoclean jml player_bopping


    org $00CEB1|!bank
        autoclean jml player_primary_animation_logic
        cape_spin_interaction:
            phb
            phk 
            plb 
            jsr $D044
            plb 
            rtl
        player_update_speeds:
            phb
            phk 
            plb 
            jsr $DC2D
            plb 
            rtl 
        player_apply_gravity:
            phb
            phk 
            plb 
            jsr $D92E
            plb 
            rtl 

    org $00CEA1|!bank
        db $00,$00,$01,$01
    org $00CA31|!bank
        autoclean jml player_peace_pose_handler
    org $00CA3A|!bank
        player_peace_pose_handler_return:

    org $00D1A8|!bank
        autoclean jml player_entering_door_pose_handler
    org $00D1B2|!bank
        player_entering_door_pose_handler_return:
    org $00D209|!bank
        autoclean jml player_entering_vertical_pipe_pose_handler
    org $00D20E|!bank
        player_entering_vertical_pipe_pose_handler_return:
    org $00D228|!bank
        lda $00

    org $00CDAD|!bank
        autoclean jml player_on_yoshi_pose_handler
    org $00CDC6|!bank
        player_on_yoshi_pose_handler_return:

    org $00D0B8|!bank
        autoclean jml player_death_pose_handler
    org $00D0BD|!bank
        player_death_pose_handler_return:
    org $00D10C|!bank
        autoclean jml player_death_animation_handler
    org $00D11C|!bank
        player_death_animation_handler_return:

    org $00D130|!bank
        autoclean jsl player_grow_shrink_pose_handler

    org $00D181|!bank
        autoclean jml player_grab_flower_pose_handler
    org $00D187|!bank
        player_grab_flower_pose_handler_return:
    
    org $00DA8D|!bank
        autoclean jml player_swimming_pose_handler
    org $00DAA5|!bank
        player_swimming_pose_handler_return:

    org $00DBCA|!bank
        autoclean jml player_climbing_pose_handler
    org $00DBD0|!bank
        player_climbing_pose_handler_return:
    org $00DB78|!bank
        autoclean jml player_climbing_turning_pose_handler
    org $00DB8C|!bank
        autoclean jml player_climbing_punching_pose_handler
    org $00DB92|!bank
        player_climbing_animaitons_handler_return:
    
    org $00CCD8|!bank
        autoclean jsl player_stunned_pose_handler

    org $00CD95|!bank
        autoclean jml player_pballoon_pose_handler
    org $00CDA5|!bank
        player_pballoon_pose_handler_return:

pullpc

;################################################
;# Primary pose handler

player_poses_handler:
    lda !player_flash_timer
    beq .not_flashing
    lsr #3
    tax 
    lda.l $00E292|!bank,x
    and !player_flash_timer
    ora !player_frozen
    ora $9D
    bne .not_flashing
    plb 
    rtl 

.not_flashing
    phb
    phk
    plb

    lda #$00
    sta !player_extra_tile_settings         ; Extra graphics settings
    sta !player_extra_tile_offset_x         ; Extra graphics relative X position
    sta !player_extra_tile_offset_x+1
    sta !player_extra_tile_offset_y         ; Extra graphics relative Y position
    sta !player_extra_tile_offset_y+1
    sta !player_extra_tile_frame            ; Extra graphics tile
    sta !player_extra_tile_oam              ; Extra graphics OAM slot

    jsr global_animations
    jsr powerup_animations
if !ENABLE_POSE_DEBUG == !yes
    jsr debug_pose_viewer
endif
    jsr setup_player_exgfx
    jsr smooth_animations
    jsr tilemap_handling
    jsr setup_player_displacements

    plb
    jml $00E3C0|!bank


;################################################
;# Runs powerup specific pose handling

powerup_animations:
    lda !player_powerup
    rep #$30
    and #$0003
    asl 
    tax 
    lda.w .powerup_image_pointers,x
    sta $00
    sep #$30
    ldx #$00
    jsr ($0000|!dp,x)
.return_image
    rts 

.powerup_image_pointers
    dw small_animations
    dw big_animations
    dw cape_animations
    dw fire_animations

;################################################
;# Runs graphic set specific tilemap handling code

tilemap_handling:
    lda !player_graphics_index
    rep #$30
    and #$00FF
    asl 
    tax 
    lda.w .tilemap_logic_pointers,x
    sta $00
    sep #$30
    ldx #$00
    jsr ($0000|!dp,x)
.return
    rts

.tilemap_logic_pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw tilemap_handling_return
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.tilemap_data
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_tilemap
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.tilemap_logic_codes
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_tilemap_exist} == 1
                gfx_!{_num}_tilemap:
                    incsrc "!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_tilemap.asm"
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Prepares player ExGFX data for later usage

setup_player_exgfx:
    lda !player_graphics_bypass
    bne .skip_setting_index
.regular_gfx_rules
    rep #$20
    lda !player_powerup
    and #$00FF
    ldx !player_num
    beq .p1
.p2 
    clc 
    adc.w #$0004
.p1 
    tax 
    sep #$20
    lda.l .index,x
    sta !player_graphics_index
    lda.l .extra_index,x
    sta !player_graphics_extra_index
    sep #$10
.skip_setting_index
    rts 

.index
    db !small_p1_gfx_num
    db !big_p1_gfx_num
    db !cape_p1_gfx_num
    db !fire_p1_gfx_num
    db !small_p2_gfx_num
    db !big_p2_gfx_num
    db !cape_p2_gfx_num
    db !fire_p2_gfx_num

.extra_index
    db !small_p1_extra_gfx_num 
    db !big_p1_extra_gfx_num
    db !cape_p1_extra_gfx_num 
    db !fire_p1_extra_gfx_num
    db !small_p2_extra_gfx_num 
    db !big_p2_extra_gfx_num
    db !cape_p2_extra_gfx_num 
    db !fire_p2_extra_gfx_num

;################################################
;# Prepares player displacements for later usage

setup_player_displacements:
    lda !player_graphics_index
    rep #$20
    and #$00FF
    asl 
    tax 
    lda.w player_x_disp_handler_pointers,x
    sta $6B
    lda.w player_y_disp_handler_pointers,x
    sta $6E
    ldx.b #bank(player_x_disp_handler_pointers)
    stx $6D
    ldx.b #bank(player_y_disp_handler_pointers)
    stx $70
    sep #$20
    rts 

;################################################
;# X displacements for the player

player_x_disp_handler:
    pha
    lda !player_graphics_disp_settings
    lsr 
    bcs .ram_table
.rom_table
    pla 
    phy
    txy 
    adc [$6B],y
    ply 
    rtl
.ram_table
    pla 
    clc 
    adc !player_graphics_x_disp,x
    rtl

.pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_x_disp
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Y displacements for the player

player_y_disp_handler:
    pha
    lda !player_graphics_disp_settings
    lsr 
    bcs .ram_table
.rom_table
    pla 
    phy
    txy 
    adc [$6E],y
    ply 
    rtl
.ram_table
    pla 
    clc 
    adc !player_graphics_y_disp,x
    rtl


.pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_y_disp
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Separate the file for animations

    incsrc "animation_logic.asm"

;################################################
;# Debug: Pose viewer

if !ENABLE_POSE_DEBUG == !yes
debug_pose_viewer:
    lda $71
    bne ++
    lda $16
    and #$04
    beq +
    lda !debug_ram
    dec 
    bmi +
    sta !debug_ram
+   
    lda $16
    and #$08
    beq +
    lda !debug_ram
    inc 
    cmp #$80
    bcs +
    sta !debug_ram
+   
    lda !debug_ram
    sta !player_pose_num
++
    rts 
endif



