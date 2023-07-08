;##################################################################################################
;# GFX set: Template
;# Author: lx5
;# Description: Template file

;################################################
;# Walk frames config

;# How many frames for walking this GFX has
;# This define also controls the length of each entry under the .walk_animations
;# table in the tilemap file. You may need to edit that file to properly expand
;# the walking frames of this GFX set.
!default_walk_frames = $02

;################################################
;# Pose numbers for specific actions
;# Those values are the indexes used for the tilemap table

;# Idle pose numbers
!default_idle_pose = $00
!default_idle_carry_pose = $07

;# Jumping pose numbers
!default_jump_pose = $0B
!default_jump_carry_pose = $09
!default_jump_max_speed_pose = $0C

;# Falling pose number
!default_falling_pose = $24

;# Braking/Turning around poses
!default_braking_pose = $0D

;# Stunned pose number
!default_stunned_pose = $0F

;# Angled pose number
!default_angled_pose = $10

;# Looking up pose numbers
!default_looking_up_pose = $03
!default_looking_up_carry_pose = $0A

;# Crouching pose numbers
!default_crouching_pose = $3C
!default_crouching_with_item_pose = $1D

;# Sliding pose number
!default_sliding_pose = $1C

;# Kicking something pose number
!default_kicking_pose = $0E

;# Picking up something number
!default_pick_up_pose = $1D

;# Shooting a fireball while swimming pose numbers
;# The game has a check for carrying something and give it a different pose... dunno why.
!default_swimming_shooting_fireball_pose = $29
!default_swimming_shooting_fireball_carry_pose = $29

;# Climbing a net pose numbers
;# The "back" one refers to the player showing their back to the camera
;# while "front" refers to the player showing their face to the camera
!default_climbing_back_pose = $15
!default_climbing_front_pose = $22

;# Facing the screen pose number
;# Used when the player turns around with an item and enters a vertical pipe
;# Kinda makes "enter_vertical_pipe_pose" redundant lol
!default_facing_screen_pose = $0F

;# Entering a door or a horizontal pipe pose numbers
!default_enter_door_pipe_pose = $00
!default_enter_door_pipe_on_yoshi_pose = $00

;# Entering a vertical pipe pose numbers
!default_enter_vertical_pipe_up_pose = $0F
!default_enter_vertical_pipe_down_pose = $0F
!default_exit_vertical_pipe_up_pose = $0F
!default_exit_vertical_pipe_down_pose = $0F
!default_enter_vertical_pipe_up_carry_pose = $0F
!default_enter_vertical_pipe_down_carry_pose = $0F
!default_exit_vertical_pipe_up_carry_pose = $0F
!default_exit_vertical_pipe_down_carry_pose = $0F
!default_enter_vertical_pipe_up_on_yoshi_pose = $21
!default_enter_vertical_pipe_down_on_yoshi_pose = $21
!default_exit_vertical_pipe_up_on_yoshi_pose = $21
!default_exit_vertical_pipe_down_on_yoshi_pose = $21

;# Yoshi related poses
!default_on_yoshi_idle_pose = $20
!default_on_yoshi_turning_pose = $21
!default_on_yoshi_crouching_pose = $1D
!default_on_yoshi_spitting_tongue_1_pose = $27
!default_on_yoshi_spitting_tongue_2_pose = $28

;# Shooting fireball pose numbers
!default_shooting_fireball_pose = $3F
!default_shooting_fireball_in_air_pose = $16

;# P-Balloon pose numbers
!default_pballoon_pose = $42
!default_pballoon_transition_pose = $0F

;# Peace pose numbers
!default_peace_pose = $26
!default_peace_on_yoshi_pose = $14

;# Death pose number
;# Note that this will only work on powerup $00 unless you disable it from happening with an external patch
!default_death_pose = $3E

;# Player grabbing a Fire Flower pose number
;# Note: This animation didn't exist in the original game, but it can handle giving the player a specific a pose.
!default_grab_flower_pose = $00

;################################################
;# Mandatory macro (do not touch).

%setup_general_gfx_defines(!default_gfx_num)