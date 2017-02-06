C $Header: /u/gcmpack/MITgcm/pkg/gchem/GCHEM_OPTIONS.h,v 1.9 2011/12/24 01:04:47 jmc Exp $
C $Name: checkpoint64v $
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

#ifndef GCHEM_OPTIONS_H
#define GCHEM_OPTIONS_H
#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"

#ifdef ALLOW_GCHEM

CBOP
C    !ROUTINE: GCHEM_OPTIONS.h
C    !INTERFACE:

C    !DESCRIPTION:
C options for biogeochemistry package
CEOP

#undef GCHEM_SEPARATE_FORCING
c undefining gchem_separate_forcing actives BFMcoupler_calc_tendency and add_tendency
c #define GCHEM_SEPARATE_FORCING
c defining gchem_separate_forcing actives GCHEM_FORCING_SEP and there BFMcoupler_calc_tendency is used

#endif /* ALLOW_GCHEM */
#endif /* GCHEM_OPTIONS_H */
