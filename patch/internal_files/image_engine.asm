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



    org $00CFEE|!bank
        autoclean jsl player_walk_frames_handler
        nop
    org $00D00A|!bank
        autoclean jml player_walk_frames_logic



    org $00E18E|!bank
        player_default_cape_table:
            db $00,$00,$00,$00,$00,$00,$00,$00      ;[00-07]
            db $00,$00,$00,$00,$00,$0D,$00,$10      ;[08-0F]
            db $13,$22,$25,$28,$00,$16,$00,$00      ;[10-17]
            db $00,$00,$00,$00,$00,$08,$19,$1C      ;[18-1F]
            db $04,$1F,$10,$10,$00,$16,$10,$06      ;[20-27]
            db $04,$08,$FF,$FF,$FF,$FF,$FF,$43      ;[28-2F]
            db $00,$00,$00,$00,$00,$00,$00,$00      ;[30-37]
            db $16,$16,$00,$00,$08                  ;[38-3C]
            db $00,$00,$00,$00,$00,$00,$10,$04      ;[3D-44]
            db $00                                  ;[45]

    org $00E1D4|!bank                               ;$00E1D4    | Data on Mario's cape, indexed by values in $00E18E. Each entry is up to 5 bytes long.
        db $06,$00,$06,$00,$86,$02,$06,$03	;MASK,DYNAMIC,MASK,DYNAMIC,MASK,DYNAMIC,MASK,DYNAMIC
        db $06,$01,$06,$42,$06,$06,$02,$00	;MASK,DYNAMIC,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION
        db $06,$0A,$06,$06,$06,$0E,$86,$0A	;MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC
        db $06,$86,$0A,$0A,$86,$20,$08,$06	;POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK
        db $00,$02,$06,$2C,$10,$06,$40,$10	;DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION
        db $06,$2E,$10,$FF,$FF,$FF,$FF,$FF	;MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,TILE1,TILE2
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF	;MASK,DYNAMIC,POSITION,TILE1,TILE2,MASK,DYNAMIC,POSITION
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF	;TILE1,TILE2,MASK,DYNAMIC,POSITION,TILE1,TILE2,MASK
        db $FF,$FF,$FF,$06,$0E,$1E		;DYNAMIC,POSITION,TILE1,MASK,DYNAMIC,POSITION
        warnpc $00E21A|!bank

    org $00E23A|!bank            ;other cape tiles.
        db $00,$00,$20,$00,$24,$24,$24,$24
        db $26,$26,$26,$26,$06,$06,$06,$06
        db $04,$04,$04,$04,$02,$02,$02,$02
        db $08,$08,$08,$08,$28,$28,$28,$28
        db $2A,$2A,$2A,$2A,$22,$22,$22,$22
        db $0C,$0C,$0C,$0C


    org $00D1AE|!bank ;Animation frame for Mario entering horizontal pipe on Yoshi
        db $1D          ;Remapped from $29 to $1D (Ducking with Item/Ducking on Yoshi)

    org $00DCEC|!bank    ;PosPointPointer
        player_default_data_00DCEC:
            db $00,$00,$00,$00,$00,$00,$00,$00    ;00-07    \
            db $00,$00,$00,$00,$00,$00,$00,$00    ;08-0F    |
            db $04,$02,$02,$02,$00,$00,$00,$00    ;10-17    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;18-1F    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;20-27    |Mario's pose number
            db $00,$00,$00,$00,$00,$00,$00,$00    ;28-2F    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;30-37    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;38-3F    |
            db $00,$00,$00,$00,$00,$00    ;40-45    /

    org $00DD32|!bank    ;PosPoint
        player_default_disp_index:
            db $00,$08,$10,$18,$20,$28,$00,$00    ;00-07
            db $00,$00,$00,$00,$00,$00,$00,$00    ;08-0F
            db $00,$00,$00,$00,$00,$00,$00,$00    ;10-17
            db $00,$00,$00,$00    ;18-1B

    org $00DD4E|!bank    ;X positions
        player_default_x_disp:
            dw $FFF8,$FFF8,$0008,$0008    ;[00]    Normal (facing left)
            dw $0008,$0008,$FFF8,$FFF8    ;[08]    Normal (facing right)
            dw $0007,$0007,$0017,$0017    ;[10]    Wall running offsets (wall on left)
            dw $FFFA,$FFFA,$FFEA,$FFEA    ;[18]    Wall running offsets (wall on right)
            dw $0005,$0005,$0015,$0015    ;[20]    Wall triangle offsets (^ <-)
            dw $FFFC,$FFFC,$FFEC,$FFEC    ;[28]    Wall triangle offsets (-> ^)
            ;below are free to use
            dw $FFF8,$FFF8,$0008,$0008    ;[30]
            dw $0008,$0008,$FFF8,$FFF8    ;[38]
            dw $FFF8,$FFF8,$0008,$0008    ;[40]
            dw $0008,$0008,$FFF8,$FFF8    ;[48]
            dw $FFF8,$FFF8,$0008,$0008    ;[50]
            dw $0008,$0008,$FFF8,$FFF8    ;[58]
            dw $FFF8,$FFF8,$0008,$0008    ;[60]
            dw $0008,$0008,$FFF8,$FFF8    ;[68]
            dw $FFF8,$FFF8,$0008,$0008    ;[70]
            dw $0008,$0008,$FFF8,$FFF8    ;[78]
            dw $0000,$0000    ;[80]
            ;;;Cape X positions;;;
            dw $000A,$FFF6    ;[84]
            dw $0008,$FFF8,$0008,$FFF8
            dw $0000,$0004,$FFFC,$FFFE
            dw $0002,$000B,$FFF5,$0014
            dw $FFEC,$000E,$FFF3,$0008
            dw $FFF8,$000C,$0014,$FFFD
            dw $FFF4,$FFF4,$000B,$000B
            dw $0003,$0013,$FFF5,$0005
            dw $FFF5,$0009,$0001,$0001
            dw $FFF7,$0007,$0007,$0005
            dw $000D,$000D,$FFFB,$FFFB
            dw $FFFB,$FFFF,$000F,$0001
            dw $FFF9,$0000

    org $00DE32|!bank    ;Y positions
        player_default_y_disp:
            dw $0001,$0011,$0001,$0011    ;[00]    Normal (facing left)
            dw $0001,$0011,$0001,$0011    ;[08]    Normal (facing right)
            dw $000F,$001F,$000F,$001F    ;[10]    Wall running offsets (wall on left)
            dw $000F,$001F,$000F,$001F    ;[18]    Wall running offsets (wall on right)
            dw $0005,$0015,$0005,$0015    ;[20]    Wall triangle offsets (^ <-)
            dw $0005,$0015,$0005,$0015    ;[28]    Wall triangle offsets (-> ^)
            ;below are free to use
            dw $0001,$0011,$0001,$0011    ;[30]
            dw $0001,$0011,$0001,$0011    ;[38]
            dw $0001,$0011,$0001,$0011    ;[40]
            dw $0001,$0011,$0001,$0011    ;[48]
            dw $0001,$0011,$0001,$0011    ;[50]
            dw $0001,$0011,$0001,$0011    ;[58]
            dw $0001,$0011,$0001,$0011    ;[60]
            dw $0001,$0011,$0001,$0011    ;[68]
            dw $0001,$0011,$0001,$0011    ;[70]
            dw $0001,$0011,$0001,$0011    ;[78]
            dw $0000,$0000    ;[80]
            ;;;Cape Y positions;;;
            dw $000B,$000B    ;[84]
            dw $0011,$0011,$FFFF,$FFFF
            dw $0010,$0010,$0010,$0010
            dw $0010,$0010,$0010,$0015
            dw $0015,$0025,$0025,$0004
            dw $0004,$0004,$0014,$0014
            dw $0004,$0014,$0014,$0004
            dw $0004,$0014,$0004,$0004
            dw $0014,$0000,$0008,$0000
            dw $0000,$0008,$0000,$0000
            dw $0010,$0018,$0000,$0010
            dw $0018,$0000,$0010,$0000
            dw $0010,$FFF8

    

pullpc
    


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
;# Edit amount of walking poses

player_walk_frames_handler:
    phx
    lda !player_graphics_index
    tax 
    lda.l .idle_pose,x 
    sta !player_idle_pose
    lda.l .carry_pose,x
    sta !player_idle_carry_pose
    lda.l .angled_pose,x 
    sta !player_angled_pose
    lda.l .looking_up_pose,x 
    sta !player_looking_up_pose
    lda.l .looking_up_carry_pose,x 
    sta !player_looking_up_carry_pose
    lda.l .walk_frames,x
    inc 
    sta !player_walking_frames
    dec 
    plx
    rtl

.walk_frames
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $02
        else 
            if defined("gfx_!{_num}_walk_frames")
                db !{gfx_!{_num}_walk_frames}-1
            else
                db $02
            endif
        endif
        !i #= !i+1
    endif
    
.idle_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else 
            if defined("gfx_!{_num}_idle_pose")
                db !{gfx_!{_num}_idle_pose}
            else
                db $00
            endif
        endif
        !i #= !i+1
    endif

.carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $07
        else 
            if defined("gfx_!{_num}_idle_carry_pose")
                db !{gfx_!{_num}_idle_carry_pose}
            else
                db $07
            endif
        endif
        !i #= !i+1
    endif

.looking_up_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $03
        else 
            if defined("gfx_!{_num}_looking_up_pose")
                db !{gfx_!{_num}_looking_up_pose}
            else
                db $03
            endif
        endif
        !i #= !i+1
    endif
.looking_up_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0A
        else 
            if defined("gfx_!{_num}_looking_up_carry_pose")
                db !{gfx_!{_num}_looking_up_carry_pose}
            else
                db $0A
            endif
        endif
        !i #= !i+1
    endif

.angled_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $10
        else 
            if defined("gfx_!{_num}_carry_pose")
                db !{gfx_!{_num}_angled_pose}
            else
                db $10
            endif
        endif
        !i #= !i+1
    endif


player_walk_frames_logic:
    phb
    phk 
    plb 
    tax
    lda $13E3|!addr
    bne .wallrunning
    lda $148F|!addr
    beq .no_carry
    lda $7B
    bne .not_idle_c
    lda $13DE|!addr
    bne +
    lda !player_idle_carry_pose
    jmp .idle
+   
    lda !player_looking_up_carry_pose
    jmp .idle
.not_idle_c
    txa 
    clc 
    adc !player_walking_frames
    adc !player_walking_frames
    tax 
    bra .do_things
.wallrunning
    tay 
    and #$01
    sta $76
    lda !player_angled_pose
    cpy #$06
    bcc .idle
    txa 
    clc 
    adc !player_walking_frames
    adc !player_walking_frames
    adc !player_walking_frames
    tax 
    bra .do_things
.no_carry
    lda $14A0|!addr
    cmp #$10
    ora $13E4|!addr
    cmp #$70
    bcc .not_idle
    txa 
    clc 
    adc !player_walking_frames
    tax
    bra .do_things
.not_idle
    lda $7B
    bne .do_things
    lda $13DE|!addr
    bne +
    lda !player_idle_pose
    bra .idle
+   
    lda !player_looking_up_pose
    bra .idle
.do_things
    rep #$20
    lda !player_graphics_index
    and #$00FF
    asl 
    tay 
    lda .animation_ptrs,y
    sta $00
    sep #$20
    txy 
    lda ($00),y
.idle
    plb 
    jml $00D030|!bank

.animation_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_walk_animations
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Smooth animations handler

smooth_animations:
    lda !player_graphics_index
    tay 
    lda.w smooth_anim_enable,y
    bne .enabled
    lda !player_pose_num
    sta !player_extended_anim_pose
    rts 

.enabled
    lda !player_pose_num
    cmp !player_previous_pose_num
    beq .not_new_animation
    sta !player_previous_pose_num
    tay 

    lda !player_graphics_index
    asl 
    tax 
    rep #$20
    lda.w smooth_anim_index_ptrs,x
    sta $00
    sep #$20

    lda ($00),y
    sta !player_extended_anim_num
    beq .abort
    lda #$FF
    sta !player_extended_anim_index
    bra .next_smooth_frame

.not_new_animation
    lda !player_extended_anim_num
    beq .return

    lda !player_extended_anim_timer
    beq .next_smooth_frame
    dec 
    sta !player_extended_anim_timer
    rts 

.abort
    tya 
    sta !player_extended_anim_pose
    rts 

.next_smooth_frame
    lda !player_extended_anim_index
    inc 
    sta !player_extended_anim_index

    lda !player_extended_anim_index
    asl 
    pha
    lda !player_extended_anim_num
    dec 
    asl 
    tay 
    lda !player_graphics_index
    asl 
    tax 
    rep #$20
    lda.w smooth_anim_pointers_ptrs,x
    sta $00
    lda ($00),y
    sta $00
    ply 
    lda ($00),y
    sep #$20
    sta !player_extended_anim_pose
    xba 
    sta !player_extended_anim_timer
    cmp #$FF
    beq .end_animation
    cmp #$FE
    beq .loop_animation
    cmp #$FD
    beq .jump_to_animation
.return
    rts 
.jump_to_animation
    xba 
    sta !player_extended_anim_num
.loop_animation
    lda #$FF
    sta !player_extended_anim_index
    jmp .next_smooth_frame
.end_animation
    stz !player_extended_anim_num
    rts 

smooth_anim_enable:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else
            db !{gfx_!{_num}_animations_exist} 
        endif
        !i #= !i+1
    endif

smooth_anim_index_ptrs:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_animations_exist} == 1
                dw gfx_!{_num}_smooth_anim_index
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

smooth_anim_pointers_ptrs:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_animations_exist} == 1
                dw gfx_!{_num}_smooth_anim_animations
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

smooth_anim_tables:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_animations_exist} == 1
                gfx_!{_num}_smooth_anim:
                    incsrc "!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_animations.asm"
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Global animations

    incsrc "../player_graphics/global_animations.asm"
    incsrc "../player_graphics/powerup_animations.asm"


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