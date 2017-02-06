C  BFMcoupler/BFMcoupler_ini_forcing.F, v 1.0
C -----------------------------------------------------------------------------

C Copyright (C) 2017 Gianpiero Cossarini (gcossarini@inogs.it)

C This program is free software; you can redistribute it and/or modify it
C under the terms of the GNU General Public License as published by the Free
C Software Foundation; either version 3 of the License, or (at your option)
C any later version.
C
C This program is distributed in the hope that it will be useful,
C but WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C GNU General Public License for more details.

C -----------------------------------------------------------------------------

#include "BFMcoupler_OPTIONS.h"

CBOP
C !ROUTINE: BFMcoupler_ini_forcing

C !INTERFACE: ==========================================================
      SUBROUTINE BFMcoupler_ini_forcing( myThid )

C !DESCRIPTION:
c initializes forcing fields to zero
c (or to reasonable values)

C !USES: ===============================================================
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "BFMcoupler_VARS.h"
#include "BFMcoupler_LOAD.h"  

C !INPUT PARAMETERS: ===================================================
C  myThid               :: thread number
      INTEGER myThid
CEOP

#ifdef ALLOW_BFMCOUPLER

c !LOCAL VARIABLES: ===================================================
       INTEGER bi,bj,i,j,k
#if (defined (READ_PAR)  || defined (USE_QSW))
       CHARACTER*(MAX_LEN_MBUF) msgBuf   !!! PER LA LETTURA DELLA KPAR
#endif

      CALL LEF_ZERO( atmosP0,myThid )
      CALL LEF_ZERO( atmosP1,myThid )
      CALL LEF_ZERO( atmosPCO20,myThid )
      CALL LEF_ZERO( atmosPCO21,myThid )
#ifdef READ_xESP
      CALL LEF_ZERO( xESP0,myThid ) ! KPAR
      CALL LEF_ZERO( xESP1,myThid ) 
#endif
#ifdef READ_PAR
      CALL LEF_ZERO( spar0,myThid ) ! surface PAR
      CALL LEF_ZERO( spar1,myThid ) 
#endif
      CALL LEF_ZERO( N1p_dep0,myThid ) ! N1p deposition
      CALL LEF_ZERO( N1p_dep1,myThid ) 
      CALL LEF_ZERO( N3n_dep0,myThid ) ! N3n deposition
      CALL LEF_ZERO( N3n_dep1,myThid ) 

#ifdef READ_PAR
#ifdef USE_QSW
        WRITE(msgBuf,'(2A)')
     &       ' BFMcoupler_INI_FORCING: You can not use READ_PAR ',
     &       ' and USE_QSW'
        CALL PRINT_ERROR( msgBuf, myThid )
        STOP 'ABNORMAL END: S/R BFMcoupler_INI_FORCING'
#endif
#endif

c set reasonable values to those that need at least something
       DO bj = myByLo(myThid), myByHi(myThid)
        DO bi = myBxLo(myThid), myBxHi(myThid)
         DO j=1-Oly,sNy+Oly
          DO i=1-Olx,sNx+Olx
             AtmosP(i,j,bi,bj)   = 1. _d 0*maskC(i,j,1,bi,bj)
             AtmosPCO2(i,j,bi,bj) = 390. _d 0*maskC(i,j,1,bi,bj) ! 2012 CO2 atm concec [ppm]
             xESP(i,j,bi,bj)     = 0.04*maskC(i,j,1,bi,bj) ! kpar [m-1]
             spar(i,j,bi,bj)    = 250. _d 0*maskC(i,j,1,bi,bj)  !surface par [uEin/m2/s]
             N1p_dep(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N1p deposition
             N3n_dep(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N3n deposition

             DO k = 1,Nr
                PH(i,j,k,bi,bj)=8.0
             ENDDO

          ENDDO
         ENDDO
        ENDDO
       ENDDO


#endif /* ALLOW_BFMCOUPLER */
      RETURN
      END
