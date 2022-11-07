;##################################################################################################
;# GFX set: Small Mario
;# Author: Nintendo
;# Description: Default set for Small Mario

;################################################
;# Walk frames config

;# How many frames for walking this GFX has
;# This define also controls the length of each entry under the .walk_animations
;# table in the tilemap file. You may need to edit that file to properly expand
;# the walking frames of this GFX set.
!small_mario_walk_frames = $02

;# Idle pose numbers
!small_mario_idle_pose = $00
!small_mario_idle_carry_pose = $07

;# Angled pose number
!small_mario_angled_pose = $10

;# Looking up pose numbers
!small_mario_looking_up_pose = $03
!small_mario_looking_up_carry_pose = $0A


;################################################
;# Mandatory macro (do not touch).

%setup_general_gfx_defines(!small_mario_gfx_num)