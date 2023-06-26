include 
;##################################################################################################
;# Customization

;################################################
;# Option helper
;# You shouldn't touch these

; Used for options below.
!yes = 1
!no = 0



;################################################
;# SA-1 Compat defines

if read1($00FFD5) == $23
    !SA1 = 1
    !dp = $3000
    !addr = $6000
    !bank = $000000
else
    !SA1 = 0
    !dp = $0000
    !addr = $0000
    !bank = $800000
endif



;################################################
;# Readme confirmation

;# Set it to !yes to be able to insert the patch. 
;# I hope you did read the readme & wiki.

!i_read_the_readme = !no



;################################################
;#  DEBUG

;# Enables debugging features:
;#  - Change player poses with UP/DOWN
!ENABLE_POSE_DEBUG = !no

;# Prints extra information in the console
!ENABLE_VERBOSE = !no



;################################################
;# Free RAM blocks

;# Free WRAM used in LoROM ROMs. Needs at least 478 consecutive bytes.
!gfx_ram_block = $7E2000   

;# Free BW-RAM used in SA-1 ROMs. Needs at least 478 consecutive bytes.
!gfx_ram_block_sa1 = $404000   



;################################################
;# Powerup specifications

;# Details:
;#  gfx_num: Slot number for the specified powerup graphics
;#  pal_num: Slot number for the specified powerup palette
;#  extra_gfx_num: Slot number for the specified powerup extra graphics

;# Player 1

!small_p1_gfx_num = $00
!big_p1_gfx_num = $01
!cape_p1_gfx_num = $01
!fire_p1_gfx_num = $01

!small_p1_pal_num = $00
!big_p1_pal_num = $00
!cape_p1_pal_num = $00
!fire_p1_pal_num = $03

!small_p1_extra_gfx_num = $00
!big_p1_extra_gfx_num = $00
!cape_p1_extra_gfx_num = $02
!fire_p1_extra_gfx_num = $00

;# Player 2

!small_p2_gfx_num = $00
!big_p2_gfx_num = $01
!cape_p2_gfx_num = $01
!fire_p2_gfx_num = $01

!big_p2_pal_num = $04
!small_p2_pal_num = $04
!cape_p2_pal_num = $04
!fire_p2_pal_num = $05

!small_p2_extra_gfx_num = $00
!big_p2_extra_gfx_num = $00
!cape_p2_extra_gfx_num = $02
!fire_p2_extra_gfx_num = $00


;################################################
;# Palette customization

;# Color number of where the player palette will START being uploaded to
!palette_transfer_start = $86

;# Color number of where the player palette will END being uploaded to
!palette_transfer_end = $8F

;# How many frames the palette animation has (grabbing a fire flower)
;# This value MUST be a power of 2 minus 1 ($01,$03,$07,$0F,$1F,$3F,$7F,$FF)
!palette_animation_frames = $03

;# How many frames the star palette animation has
;# This value MUST be a power of 2 minus 1 ($01,$03,$07,$0F,$1F,$3F,$7F,$FF)
!palette_star_animation_frames = $03



;################################################
;# Miscelaneous customization

;# DMA Channel used for the VRAM transfers during V-Blank
!dma_channel = 2



;##################################################################################################
;# Macros & global defines.
;# Nothing past this point should be modified at all unless you know what you're doing.

;#########################################################################
;# Macros

	!_error_detected = 0
	!_warn_detected = 0
    incsrc "internal_files/weird_macros.asm"
    incsrc "internal_files/list_parser.asm"

;################################################
;# Setup for GFX defines.
;# Input:
;#    <num> - GFX number to process
;#        
;# Output:
;#         A bunch of defines with generic names to make everything work automatically


macro setup_general_gfx_defines(num)
    !_name := !gfx_<num>_internal_name

    if defined("!{_name}_data_loc")
        !gfx_<num>_data_loc := !{!{_name}_data_loc}
    endif

    %define_individual_define("walk_frames", <num>)

    %define_individual_define("idle_pose", <num>)
    %define_individual_define("idle_carry_pose", <num>)
    %define_individual_define("angled_pose", <num>)
    %define_individual_define("looking_up_pose", <num>)
    %define_individual_define("looking_up_carry_pose", <num>)
    %define_individual_define("crouching_pose", <num>)
    %define_individual_define("crouching_with_item_pose", <num>)
    %define_individual_define("shooting_fireball_pose", <num>)
    %define_individual_define("shooting_fireball_in_air_pose", <num>)
    %define_individual_define("kicking_pose", <num>)
    %define_individual_define("pick_up_pose", <num>)
    %define_individual_define("facing_screen_pose", <num>)
    %define_individual_define("jump_carry_pose", <num>)
    %define_individual_define("jump_pose", <num>)
    %define_individual_define("jump_max_speed_pose", <num>)
    %define_individual_define("falling_pose", <num>)
    %define_individual_define("braking_pose", <num>)
    %define_individual_define("sliding_pose", <num>)
    %define_individual_define("peace_pose", <num>)
    %define_individual_define("peace_on_yoshi_pose", <num>)
    %define_individual_define("on_yoshi_idle_pose", <num>)
    %define_individual_define("on_yoshi_turning_pose", <num>)
    %define_individual_define("on_yoshi_crouching_pose", <num>)
    %define_individual_define("on_yoshi_spitting_tongue_1_pose", <num>)
    %define_individual_define("on_yoshi_spitting_tongue_2_pose", <num>)
    %define_individual_define("death_pose", <num>)
    %define_individual_define("grab_flower_pose", <num>)
    %define_individual_define("enter_door_pipe_pose", <num>)
    %define_individual_define("enter_door_pipe_on_yoshi_pose", <num>)
    %define_individual_define("enter_vertical_pipe_up_pose", <num>)
    %define_individual_define("enter_vertical_pipe_up_on_yoshi_pose", <num>)
    %define_individual_define("enter_vertical_pipe_down_pose", <num>)
    %define_individual_define("enter_vertical_pipe_down_on_yoshi_pose", <num>)
    %define_individual_define("exit_vertical_pipe_up_pose", <num>)
    %define_individual_define("exit_vertical_pipe_up_on_yoshi_pose", <num>)
    %define_individual_define("exit_vertical_pipe_down_pose", <num>)
    %define_individual_define("exit_vertical_pipe_down_on_yoshi_pose", <num>)
    %define_individual_define("swimming_shooting_fireball_pose", <num>)
    %define_individual_define("swimming_shooting_fireball_carry_pose", <num>)
    %define_individual_define("climbing_back_pose", <num>)
    %define_individual_define("climbing_front_pose", <num>)
    %define_individual_define("stunned_pose", <num>)
    %define_individual_define("pballoon_pose", <num>)
    %define_individual_define("pballoon_transition_pose", <num>)

endmacro

macro define_individual_define(name, num)
    if defined("!{_name}_<name>")
        !gfx_<num>_<name> := !{!{_name}_<name>}
    else 
        print "WARNING: \!!{_name}_<name> does not exist. Using default values..."
    endif
endmacro


;################################################
;# Insert engine
;# Includes an asm file and calculates its insert size

macro insert_patch_file(file_path)
    if !_error_detected != 1
        if !ENABLE_VERBOSE
            print "Processed: internal_files/<file_path>"
            print "Location: $", pc
        endif
        incsrc "internal_files/<file_path>"
        if !ENABLE_VERBOSE
            print "Modified bytes: ", bytes," bytes."
            print ""
        endif
    endif
endmacro


;################################################
;# GFX specific defines

    if !_error_detected == 0
        !i #= 0
        while !i < !max_gfx_num
            %internal_number_to_string(!i)
            if not(stringsequal("!{gfx_!{_num}_path}", "0"))
                incsrc "internal_files/!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_defs.asm"
            endif
            !i #= !i+1
        endif
    endif

;################################################
;# Internal defines
;# Nothing from here should be changed unless you remapped these RAMs to somewhere else.

!player_x_pos                   = $94
!player_x_low                   = $94
!player_x_high                  = $95
!player_y_pos                   = $96
!player_y_low                   = $96
!player_y_high                  = $97
!player_x_speed                 = $7B
!player_y_speed                 = $7D

!player_powerup                 = $19
!player_num                     = $0DB3|!addr

!player_in_air                  = $72
!player_blocked_status          = $77
!player_in_ground               = $13EF|!addr
!player_climbing                = $74
!player_crouching               = $73
!player_crouching_yoshi         = $18DC|!addr
!player_in_water                = $75
!player_in_yoshi                = $187A|!addr
!player_wallrunning             = $13E3|!addr
!player_in_slope                = $13EE|!addr
!player_spinjump                = $140D|!addr
!player_sliding                 = $13ED|!addr
!player_holding                 = $148F|!addr
!player_carrying                = $1470|!addr
!player_disable_collision       = $185C|!addr
!player_stomp_count             = $18D2|!addr
!player_frozen                  = $13FB|!addr
!player_punching                = $149E|!addr
!player_kicking                 = $149A|!addr
!player_picking_up              = $1498|!addr
!player_facing_screen           = $1499|!addr
!player_in_cloud                = $18C2|!addr
!player_looking_up              = $13DE|!addr
!player_turning_around          = $13DD|!addr

!player_item_box_2              = $0DBC|!addr
!player_item_box                = $0DC2|!addr
!player_coins                   = $0DBF|!addr
!player_lives                   = $0DBE|!addr

!player_layer                   = $13F9|!addr
!player_behind                  = !player_layer

!player_direction               = $76
!player_pose_num                = $13E0|!addr
!player_walk_pose               = $13DB|!addr
!player_cape_pose_num           = $13DF|!addr
!player_extra_tile_num          = !player_cape_pose_num
!player_previous_pose_num       = $18C5|!addr
!player_extended_anim_index     = $18C6|!addr
!player_extended_anim_num       = $18C7|!addr
!player_extended_anim_pose      = $18C8|!addr
!player_extended_anim_timer     = $18C9|!addr

!player_invulnerability_timer   = $1497|!addr
!player_flash_timer             = !player_invulnerability_timer
!player_spinjump_timer          = $13E2|!addr
!player_star_timer              = $1490|!addr
!player_dash_timer              = $13E4|!addr
!player_shoot_pose_timer        = $149C|!addr
!player_animation_timer         = $1496|!addr

!cape_interaction_flag          = $13E8|!addr
!cape_interaction_x_pos         = $13E9|!addr
!cape_interaction_y_pos         = $13EB|!addr
!cape_spin_timer                = $14A6|!addr

;################################################
;# Free RAM allocation
;# Everything is handled automatically.

if !SA1 == 1
    !gfx_ram_block = !gfx_ram_block_sa1
endif

!player_graphics_index          = !gfx_ram_block
!player_graphics_pointer        = !player_graphics_index+1
!player_graphics_bypass         = !player_graphics_pointer+3
!player_graphics_extra_index    = !player_graphics_bypass+1
!player_graphics_disp_settings  = !player_graphics_extra_index+1
!player_graphics_x_disp         = !player_graphics_disp_settings+1
!player_graphics_y_disp         = !player_graphics_x_disp+256

!player_palette_pointer         = !player_graphics_y_disp+256
!player_palette_bypass          = !player_palette_pointer+3
!player_palette_index           = !player_palette_bypass+1

!player_extra_tile_settings     = !player_palette_index+1
!player_extra_tile_offset_x     = !player_extra_tile_settings+1
!player_extra_tile_offset_y     = !player_extra_tile_offset_x+2
!player_extra_tile_frame        = !player_extra_tile_offset_y+2
!player_extra_tile_oam          = !player_extra_tile_frame+1

!player_walking_frames                  = !player_extra_tile_oam+1
!player_idle_pose                       = !player_walking_frames+1
!player_idle_carry_pose                 = !player_idle_pose+1
!player_angled_pose                     = !player_idle_carry_pose+1
!player_looking_up_pose                 = !player_angled_pose+1
!player_looking_up_carry_pose           = !player_looking_up_pose+1
!player_crouching_pose                  = !player_looking_up_carry_pose+1
!player_crouching_with_item_pose        = !player_crouching_pose+1
!player_shooting_fireball_pose          = !player_crouching_with_item_pose+1
!player_shooting_fireball_in_air_pose   = !player_shooting_fireball_pose+1
!player_kicking_pose                    = !player_shooting_fireball_in_air_pose+1
!player_pick_up_pose                    = !player_kicking_pose+1
!player_facing_screen_pose              = !player_pick_up_pose+1
!player_jump_carry_pose                 = !player_facing_screen_pose+1
!player_jump_pose                       = !player_jump_carry_pose+1
!player_jump_max_speed_pose             = !player_jump_pose+1
!player_falling_pose                    = !player_jump_max_speed_pose+1
!player_braking_pose                    = !player_falling_pose+1
!player_sliding_pose                    = !player_braking_pose+1

;cutscene           : not supported
;flying             : not supported ; 00CE79
;flying, sliding    : not supported ; 00CE7F

!player_animation_ram           = !player_sliding_pose+1

!debug_ram                      = !player_animation_ram+$40
