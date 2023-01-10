reset bytes
pushpc
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