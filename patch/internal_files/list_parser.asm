;##################################################################################################
;# This absurdly convoluted script handles the powerup list file.
;# It automatically creates and assigns values to defines based on the list.
;# In other words, it's the heart of the defines file.

;# Path
!gfx_list_path = "../graphics_list.asm"

;# Current position in the list file
!_position = 0

;# Current line being parsed
!_line = 1

!_error_msg = ""

!max_powerup_num = 0

macro setup_error_msg(msg)
    !_error_msg := "<msg>"
    !_error_detected #= 1
    !_position #= $FFFFFE
    !_exit #= 1
endmacro

macro setup_warn_msg(msg)
    warn "<msg>"
    !_warn_detected #= 1
endmacro


;##################################################################################
;# Graphics

;# Initialize defines
!i #= 0
while !i != 128
    %internal_number_to_string(!i)
    !{gfx_!{_num}_internal_name} := "0"
    !{gfx_!{_num}_path} := "0"
    !i #= !i+1
endif

!max_gfx_num = 0

;# Current position in the list file
!_position #= 0

;# Current line being parsed
!_line = 1

print "Detected graphics:"
while readfile1("!gfx_list_path", !_position, $FF) != $FF
    ;# Process number
        !_gfx_num = ""
        %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
        if !_result_hex == $20
            %setup_error_msg("Line !_line: The GFXs numbers shouldn't contain leading spaces.")
        elseif !_result_hex < $30 || !_result_hex >= $67
            %setup_error_msg("Line !_line: Invalid GFX number.")
        elseif !_result_hex >= $3A && !_result_hex <= $40
            %setup_error_msg("Line !_line: Invalid GFX number.")
        elseif !_result_hex >= $47 && !_result_hex <= $60
            %setup_error_msg("Line !_line: Invalid GFX number.")
        else
            !_position #= !_position+1
            !_gfx_num += !_result
            !_gfx_num := !_gfx_num
        endif

        if !_error_detected == 0
            !_result_hex = readfile1("!gfx_list_path", !_position, $FF)
            if !_result_hex == $20
                %setup_error_msg("Line !_line: The GFX numbers should be 2 digits long.")
            elseif !_result_hex < $30 || !_result_hex >= $67
                %setup_error_msg("Line !_line: Invalid GFX number.")
            elseif !_result_hex >= $3A && !_result_hex <= $40
                %setup_error_msg("Line !_line: Invalid GFX number.")
            elseif !_result_hex >= $47 && !_result_hex <= $60
                %setup_error_msg("Line !_line: Invalid GFX number.")
            else
                %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
                !_position #= !_position+1
                !_gfx_num += !_result
                !_gfx_num := !_gfx_num
            endif
        endif

    ;# Check if it's a duplicated GFX number
        !_exit = 0
        if !_error_detected == 1
            !_position #= $FFFFFE
            !_exit = 1
        else
            if not(stringsequal("!{gfx_!{_gfx_num}_path}", "0"))
                %setup_error_msg("Line !_line: Duplicated GFX number.")
                !_position #= $FFFFFE
                !_exit = 1
            endif
        endif

    ;# Detect proper spacing
        if !_exit == 0
            !_result_hex = readfile1("!gfx_list_path", !_position, $FF)
            if !_result_hex != $20
                %setup_error_msg("Line !_line: Invalid list entry.")
                !_position #= $FFFFFE
                !_exit = 1
            endif 
        endif

    ;# Process GFX name
        !_position #= !_position+1
        !_gfx_name = ""

        while !_exit != 1
            %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
            if !_result_hex == $FF
                !_exit = 1
            elseif !_result_hex == $0D
                !_position #= !_position+1
                if readfile1("!gfx_list_path", !_position, $FF) == $0A
                    !_position #= !_position+1
                endif
                !_exit = 1
            elseif !_result_hex == $0A
                !_position #= !_position+1
                !_exit = 1
            elseif !_result_hex == $20
                %setup_error_msg("Line !_line: Spaces in GFX names aren't supported.")
                !_position #= $FFFFFF
                !_exit = 1
            elseif !_result_hex == $FE
                %setup_error_msg("Line !_line: Unsupported character detected.")
                !_position #= $FFFFFF
                !_exit = 1
            else
                !_gfx_name += !_result
                !_gfx_name := !_gfx_name
                !_position #= !_position+1
            endif
        endif

    ;# Create defines
        !{gfx_!{_gfx_num}_internal_name} := !_gfx_name
        !{gfx_!{_gfx_num}_path} := "../player_graphics/!_gfx_name"
        !{!{_gfx_name}_gfx_num} := !_gfx_num

    ;# Test files
    
        !{gfx_!{_gfx_num}_gfx_exist} = 0
        !{gfx_!{_gfx_num}_extra_gfx_exist} = 0
        !{gfx_!{_gfx_num}_tilemap_exist} = 0
        !{gfx_!{_gfx_num}_animations_exist} = 0
        !{gfx_!{_gfx_num}_palette_exist} = 0
        !_included_files = ""
        !_path := "../player_graphics/!{_gfx_name}"
        if canreadfile1("!_path/!_gfx_name.bin", 0)
            ; regular gfx exist, expecting disp, tilemap and palettes for it, extra gfx and animation files are optional
            !{gfx_!{_gfx_num}_gfx_exist} = 1
            !_included_files += "GFX"
            if canreadfile1("!_path/!{_gfx_name}_extra.bin", 0)
                !{gfx_!{_gfx_num}_extra_gfx_exist} = 1
                !_included_files += ", extra GFX"
            endif
            if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                !{gfx_!{_gfx_num}_tilemap_exist} = 1
                !_included_files += ", tilemap"
            else
                %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a file: !{_gfx_name}_tilemap.asm")
            endif
            if canreadfile1("!_path/!{_gfx_name}_animations.asm", 0)
                !{gfx_!{_gfx_num}_animations_exist} = 1
                !_included_files += ", smooth animations"
            endif
            if canreadfile1("!_path/!{_gfx_name}.mw3", 0)
                !{gfx_!{_gfx_num}_palette_exist} = 1
                !_included_files += ", palette"
            else
                %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a palette file: !{_gfx_name}.mw3")
            endif
        else 
            ; regular gfx doesn't exist, only extra gfx should exist and throw warning for unneeded files
            if canreadfile1("!_path/!{_gfx_name}_extra.bin", 0) != 0
                !{gfx_!{_gfx_num}_extra_gfx_exist} = 1
                !_included_files += "Extra GFX"
                if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                    !{gfx_!{_gfx_num}_tilemap_exist} = 1
                    !_included_files += ", tilemap"
                    %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_tilemap.asm")
                endif
                if canreadfile1("!_path/!{_gfx_name}_animation.asm", 0)
                    !{gfx_!{_gfx_num}_animations_exist} = 1
                    !_included_files += ", smooth animations"
                    %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_animations.asm")
                endif
                if canreadfile1("!_path/!{_gfx_name}.mw3", 0)
                    !{gfx_!{_gfx_num}_palette_exist} = 1
                    !_included_files += ", palette"
                    %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}.mw3")
                endif
            else
                ; extra gfx doesn't exist, check for palette files
                if canreadfile1("!_path/!{_gfx_name}.mw3", 0) != 0
                    !{gfx_!{_gfx_num}_palette_exist} = 1
                    !_included_files += "Palette"
                    if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                        !{gfx_!{_gfx_num}_tilemap_exist} = 1
                        !_included_files += ", tilemap"
                        %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_tilemap.asm")
                    endif
                    if canreadfile1("!_path/!{_gfx_name}_animation.asm", 0)
                        !{gfx_!{_gfx_num}_animations_exist} = 1
                        !_included_files += ", smooth animations"
                        %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_animations.asm")
                    endif
                else
                    %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a file to be a valid entry: !{_gfx_name}_extra.bin or !{_gfx_name}.mw3")
                endif
            endif
        endif

        if !_position < $FFFFFE
            print "       GFX !{!{_gfx_name}_gfx_num}: !{gfx_!{_gfx_num}_internal_name} (!_included_files)"
            ;print "         Path: !{gfx_!{_gfx_num}_path}"
        endif

        if !_gfx_num >= !max_gfx_num
            !max_gfx_num #= !_gfx_num+1
        endif

    ;# Restore
        !_gfx_num = ""
        !_gfx_name = ""
        !_exit = 0
        !_line #= !_line+1

endif

if !_position >= $FFFFFE
    print ""
    print "!!!!! ERROR !!!!!"
    print "!_error_msg"
    print ""

else

    print ""
endif