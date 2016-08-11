C $Header: /MITgcm/pkg/BFMcoupler/BFMcoupler_LOAD.h,v 1.01
C 2014/04/09

C--   COMMON /BFMcoupler_LOAD/
C     BFMcoupler_ldRec     :: time-record currently loaded (in temp arrays *[1])

      COMMON /BFMcoupler_LOAD_I/ BFMcoupler_ldRec
      INTEGER BFMcoupler_ldRec(nSx,nSy)

      COMMON /BFMcouplerLOAD_RS/
     &    AtmosPCO20,AtmosPCO21,AtmosP0,AtmosP1,
     &    AtmosWIND0,AtmosWIND1,
     &    N1p_dep0,N1p_dep1,N3n_dep0,N3N_dep1
#ifdef READ_xESP
     &    ,xESP0,xESP1
#endif
#ifdef READ_PAR
     &    ,spar0,spar1
#endif
      _RS AtmosWIND0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosWIND1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosPCO20  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosPCO21  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosP0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosP1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N1p_dep0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N1p_dep1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_dep0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_dep1 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#ifdef READ_xESP
      _RS xESP0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS xESP1 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif
#ifdef READ_PAR
      _RS spar0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS spar1 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif

CEH3 ;;; Local Variables: ***
CEH3 ;;; mode:fortran ***
CEH3 ;;; End: ***
