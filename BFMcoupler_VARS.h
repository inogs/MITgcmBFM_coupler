C $Header: /MITgcm/pkg/BFMcoupler/BFMcoupler_VARS.h,v1.01
C 2014/04/09
C -----------------------------------------------------------------------------

C Copyright (C) 2016 Gianpiero Cossarini (gcossarini@inogs.it)

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
C     *==========================================================*
C     | BFMcoupler_VARS.h
C     *==========================================================*

C--   COMMON /BFMcoupler_FILENAMES/
C  BFMcoupler_atmospFile    :: file name of atmospheric pressure
C  BFMcoupler_PCO2File      :: file name of atmospheric pCO2
C  BFMcoupler_xESPFile      :: file name of satellite light extintion factor
C  BFMcoupler_N1pDepFile    :: file name of atmospheric N1p dry depotion 
C  BFMcoupler_N3nDepFile    :: file name of atmospheric N3n dry depotion 
C  BFMcoupler_sparFile      :: file name of surface photosynthetically available radiation (PAR)
C  BFMcoupler_forcingPeriod :: periodic forcing parameter specific for BFMcoupler (seconds)
C  BFMcoupler_forcingCycle  :: periodic forcing parameter specific for BFMcoupler (seconds)

      COMMON /BFMcoupler_FILENAMES/
     &    BFMcoupler_atmospFile, BFMcoupler_PCO2File,
     &    BFMcoupler_xESPFile, BFMcoupler_N1pDepFile, 
     &    BFMcoupler_N3nDepFile,BFMcoupler_sparFile,
     &    BFMcoupler_forcingPeriod, BFMcoupler_forcingCycle     

      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_atmospFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_PCO2File
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_xESPFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_sparFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N1pDepFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N3nDepFile
      _RL     BFMcoupler_forcingPeriod
      _RL     BFMcoupler_forcingCycle

C ==================================================
C include the list of BFM variables 
C and list of diagnostic of BFM
C The BFM_var_list.h must be picked up from BFM code
C ==================================================
#include "BFM_var_list.h"

       COMMON /CARBON_NEEDS/
     &              AtmosPCO2, AtmosP,AtmosWIND,PH
      _RL  AtmosPCO2(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  AtmosP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  AtmosWIND(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  PH(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy) 



       COMMON /LIGHT_NEEDS/
     &          spar,xESP,xpar
      _RL  spar(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  xESP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  xpar(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy) 

       COMMON /SEDIMENTATION_RATE/
     &      sediPI,vsed
      _RL sediPI(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy,4) ! 4 phytoplankton
      _RL vsed ! sinking rate for detritus (constant)

       COMMON /NUT_DEPOSITION/
     &          N1p_dep,N3n_dep
      _RL  N1p_dep(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  N3n_dep(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

#ifdef USE_SHADE
       COMMON /LIGHT_SHADE_VARS/
     &      p_espP1,p_espP2,p_espP3,p_espP4,p_espWATER
      _RL p_espP1
      _RL p_espP2
      _RL p_espP3
      _RL p_espP4
      _RL p_espWATER
#endif
        COMMON /BOTTOM FORCINGS/
     &    p_burial,p_fluxC_bot,p_fluxN_bot,p_fluxP_bot,p_fluxSi_bot
      _RL p_burial
      _RL p_fluxC_bot
      _RL p_fluxN_bot
      _RL p_fluxP_bot
      _RL p_fluxSi_bot



CEH3 ;;; Local Variables: ***
CEH3 ;;; mode:fortran ***
CEH3 ;;; End: ***



