C $Header: MITgcm/BFMcoupler/BFMcoupler_ini_forcing.F,v 1.01
C 2014/04/10 
C modified 3 sept 2015 by Valeria, introducing N1p, N3n, 5s, O3c, O3h contribution
C by rivers
C and in 5 sept 2017 for the bottom contributions
C and in 15 feb 2018 for the CG tracers
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
      CALL LEF_ZERO( N1p_surfF0,myThid ) ! N1p surface forcing 
      CALL LEF_ZERO( N1p_surfF1,myThid ) 
      CALL LEF_ZERO( N3n_surfF0,myThid ) ! N3n surface forcing
      CALL LEF_ZERO( N3n_surfF1,myThid ) 
      CALL LEF_ZERO( N5s_surfF0,myThid ) ! N5s surface forcing only by rivers
      CALL LEF_ZERO( N5s_surfF1,myThid )
      CALL LEF_ZERO( O3c_surfF0,myThid ) ! O3c surface forcing only by rivers
      CALL LEF_ZERO( O3c_surfF1,myThid )
      CALL LEF_ZERO( O3h_surfF0,myThid ) ! O3h surface forcing only by rivers
      CALL LEF_ZERO( O3h_surfF1,myThid )
      CALL LEF_ZERO( N1p_botF0,myThid )  ! N1p bottom forcing 
      CALL LEF_ZERO( N1p_botF1,myThid )
      CALL LEF_ZERO( N3n_botF0,myThid )  ! N3n bottom forcing 
      CALL LEF_ZERO( N3n_botF1,myThid )
      CALL LEF_ZERO( N4n_botF0,myThid )  ! N4n bottom forcing 
      CALL LEF_ZERO( N4n_botF1,myThid )
      CALL LEF_ZERO( O2o_botF0,myThid )  ! O2o bottom forcing 
      CALL LEF_ZERO( O2o_botF1,myThid )
      CALL LEF_ZERO( O3c_botF0,myThid )  ! O3c bottom forcing 
      CALL LEF_ZERO( O3c_botF1,myThid )
      CALL LEF_ZERO( O3h_botF0,myThid )  ! O3h bottom forcing 
      CALL LEF_ZERO( O3h_botF1,myThid )
      CALL LEF_ZERO( CG01_botF0,myThid )  ! CG tracers bottom forcing 
      CALL LEF_ZERO( CG01_botF1,myThid )
      CALL LEF_ZERO( CG02_botF0,myThid )  
      CALL LEF_ZERO( CG02_botF1,myThid )
      CALL LEF_ZERO( CG03_botF0,myThid )  
      CALL LEF_ZERO( CG03_botF1,myThid )
      CALL LEF_ZERO( CG04_botF0,myThid )  
      CALL LEF_ZERO( CG04_botF1,myThid )
      CALL LEF_ZERO( CG05_botF0,myThid )  
      CALL LEF_ZERO( CG05_botF1,myThid )
      CALL LEF_ZERO( CG06_botF0,myThid )  
      CALL LEF_ZERO( CG06_botF1,myThid )
      CALL LEF_ZERO( CG07_botF0,myThid )  
      CALL LEF_ZERO( CG07_botF1,myThid )
      CALL LEF_ZERO( CG08_botF0,myThid )  
      CALL LEF_ZERO( CG08_botF1,myThid )
      CALL LEF_ZERO( CG09_botF0,myThid )  
      CALL LEF_ZERO( CG09_botF1,myThid )
      CALL LEF_ZERO( CG10_botF0,myThid )
      CALL LEF_ZERO( CG10_botF1,myThid )
      CALL LEF_ZERO( CG11_botF0,myThid )
      CALL LEF_ZERO( CG11_botF1,myThid )
      CALL LEF_ZERO( CG12_botF0,myThid )
      CALL LEF_ZERO( CG12_botF1,myThid )
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
             N1p_surfF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N1p surface forcing
             N3n_surfF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N3n surface forcing
             N5s_surfF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N5s surface forcing
             O3c_surfF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! O3c surface forcing 
             O3h_surfF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! O3h surface forcing
             N1p_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj) ! N1p bottom forcing 
             N3n_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             N4n_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             O2o_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             O3c_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             O3h_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG01_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG02_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG03_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG04_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG05_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG06_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG07_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG08_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG09_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG10_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG11_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
             CG12_botF(i,j,bi,bj) = 0. _d 0*maskC(i,j,1,bi,bj)
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
