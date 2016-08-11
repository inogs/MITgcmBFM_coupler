C $Header:/MITgcm/pkg/BFMcoupler/BFMcoupler_VARDIAG_fill_diags.h,v 1.01
C fill the diagnostic memory using DIAGNOSTICS_FILL
        CALL DIAGNOSTICS_FILL(diaPPG     ,'PPG     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaNPP     ,'NPP     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaBPP     ,'BPP     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaDIC     ,'DIC     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaCO2     ,'CO2     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaHCO3    ,'HCO3    '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaCO3     ,'CO3     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaAc      ,'Ac      '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diapH      ,'pH      '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diapCO2    ,'pCO2    '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF01     ,'F01     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF02     ,'F02     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF03     ,'F03     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF04     ,'F04     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF05     ,'F05     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF06     ,'F06     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF07     ,'F07     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF08     ,'F08     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF09     ,'F09     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF10     ,'F10     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF11     ,'F11     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF12     ,'F12     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaF13     ,'F13     '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaxpar    ,'xpar    '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diawspeed  ,'wspeed  '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaRHOSitu ,'RHOSitu '
     &  ,0,Nr,2,bi,bj,myThid)
        CALL DIAGNOSTICS_FILL(diaPCO2atm ,'PCO2atm '
     &  ,0,Nr,2,bi,bj,myThid)
