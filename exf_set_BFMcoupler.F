#include "EXF_OPTIONS.h"

C--  File exf_set_BFMcoupler.F:
C--   Contents
C--   o EXF_SET_BFMcoupler

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

      SUBROUTINE EXF_SET_BFMcoupler (
     U       BFMcoupler_fld_xy, BFMcoupler_fld0, BFMcoupler_fld1,
     I       BFMcoupler_file, BFMcoupler_fldmask,
     I       fac, first, changed, useYearlyFields, BFMcoupler_period,
     I       count0, count1, year0, year1,
     I       myTime, myIter, myThid )

C     ==================================================================
C     SUBROUTINE EXF_SET_BFMcoupler
C     ==================================================================
C
C     o set BFMcoupler forcing
C

C     ==================================================================
C     SUBROUTINE EXF_SET_BFMcoupler
C     ==================================================================

      IMPLICIT NONE

C     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"
#include "GRID.h"
#include "EXF_PARAM.h"
#include "EXF_CONSTANTS.h"

C     == routine arguments ==
      _RL BFMcoupler_fld_xy(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS BFMcoupler_fld0(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS BFMcoupler_fld1(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      CHARACTER*(128) BFMcoupler_file
      CHARACTER*1 BFMcoupler_fldmask
      LOGICAL first, changed
      LOGICAL useYearlyFields
      _RL     BFMcoupler_period
      INTEGER count0, count1, year0, year1
      _RL     fac
      _RL     myTime
      INTEGER myIter
      INTEGER myThid

#ifdef ALLOW_BFMCOUPLER

C     == local variables ==

      CHARACTER*(128) BFMcoupler_file0, BFMcoupler_file1
      INTEGER bi, bj
      INTEGER i, j

C     == end of interface ==

      IF ( BFMcoupler_file .NE. ' ' ) THEN

         IF ( first ) THEN

            CALL exf_GetYearlyFieldName(
     I         useYearlyFields, twoDigitYear, BFMcoupler_period, year0,
     I         BFMcoupler_file,
     O         BFMcoupler_file0,
     I         myTime, myIter, myThid )

            _BARRIER
            CALL READ_REC_XY_RS( BFMcoupler_file0, BFMcoupler_fld1,
     &                           count0, myIter, myThid)
            _BARRIER
C-     apply mask Eventually evaluate if necessary to apply the mask: 
c                 in case it should be created a new file  exf_filter_rs.F

c     CALL EXF_FILTER_RL( BFMcoupler_fld1, BFMcoupler_fldMask,
c     &                          myThid )            
         ENDIF

         IF ( first .OR. changed ) THEN
C-     In exf_swapffields.F I add a routine exf_swapffields_xy             
c      identical to swapffields, but with fld0 and fld1 of type _RS
            CALL exf_swapffields_xy( BFMcoupler_fld0, BFMcoupler_fld1,
     &                                myThid )

            CALL exf_GetYearlyFieldName(
     I         useYearlyFields, twoDigitYear, BFMcoupler_period, year1,
     I         BFMcoupler_file,
     O         BFMcoupler_file1,
     I         myTime, myIter, myThid )

            _BARRIER
            CALL READ_REC_XY_RS( BFMcoupler_file1, BFMcoupler_fld1,
     &                           count1, myIter, myThid)
            _BARRIER
         ENDIF

         _EXCH_XY_RS(BFMcoupler_fld0, myThid )
         _EXCH_XY_RS(BFMcoupler_fld1, myThid )
         
         DO bj = myByLo(myThid),myByHi(myThid)
            DO bi = myBxLo(myThid),myBxHi(myThid)
               DO j = 1-OLy,sNy+OLy
                  DO i = 1-OLx,sNx+OLx
                     BFMcoupler_fld_xy(i,j,bi,bj) =
     &                    fac * BFMcoupler_fld0(i,j,bi,bj) +
     &                    (exf_one - fac) * BFMcoupler_fld1(i,j,bi,bj)
                  ENDDO
               ENDDO
            ENDDO
         ENDDO

      ENDIF

#endif /* ALLOW_BFMCOUPLER */

      RETURN
      END
