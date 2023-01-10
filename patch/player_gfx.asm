;##################################################################################################
;# Powerup expansion kit - Made by lx5

    print ""
    print "Player GFX Kit v1.1 - Made by lx5"
    print "Readme & documentation: https://github.com/TheLX5/PlayerGraphicsKit/wiki"
    print ""

;################################################
; Defines, do not edit these

    incsrc "defs.asm"

if !i_read_the_readme == 0
    print "Nothing was inserted."
    print "Please read the GitHub wiki."
else

if !SA1 = 1
    sa1rom
endif

if !_error_detected == 0

    if !ENABLE_VERBOSE
        print "Verbose: ON"
        print ""
    endif 

;#########################################################################
;# Insert everything

	freecode

	!i = 0
	!j = 0
	while !i < !max_gfx_num
		%internal_number_to_string(!i)
		if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_gfx_exist} != 0
                if !j == 0
                    !protected_data := "gfx_!{_num}_graphics"
                    !j #= 1
                else
                    if filesize("internal_files/!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}.bin") > $10000
                        !protected_data := "!protected_data, gfx_!{_num}_graphics, gfx_!{_num}_graphics_part2"
                    else
                        !protected_data := "!protected_data, gfx_!{_num}_graphics"
                    endif
                endif
            endif
            if !{gfx_!{_num}_extra_gfx_exist} != 0
                if !j == 0
                    !protected_data := "gfx_!{_num}_extra_graphics"
                    !j #= 1
                else
                    !protected_data := "!protected_data, gfx_!{_num}_extra_graphics"
                endif
            endif
		endif
		!i #= !i+1
	endif

    print "PROT: !protected_data"

	prot !protected_data

;################################################
;# Engines handler

    %insert_patch_file("hex_edits.asm")
    %insert_patch_file("image_engine.asm")
    %insert_patch_file("initializer.asm")
    %insert_patch_file("palette_engine.asm")
    %insert_patch_file("dma_engine.asm")
    %insert_patch_file("player_exgfx_engine.asm")
    %insert_patch_file("extra_tile_engine.asm")

;#########################################################################
;# End

    if !_warn_detected == 1
        print "WARNINGS DETECTED. Read the console for more information."
        print ""
    endif
        print "Total insert size: ", freespaceuse, " bytes"
    else 
    if !_warn_detected == 1
        print "WARNINGS DETECTED. Read the console for more information."
        print ""
    endif
        print "Nothing was inserted."
    endif

endif