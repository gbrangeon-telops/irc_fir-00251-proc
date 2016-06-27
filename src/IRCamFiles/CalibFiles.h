/**
 * @file CalibFiles.h
 * Camera calibration files utilities.
 *
 * This file defines camera calibration file utilities.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef CALIBFILES_H
#define CALIBFILES_H

#include "utils.h"

#define CALIBFILES_VERSION    2

#define VER_MACRO(m, v) JOIN(m ## _V, v)

#define VER_TYPE(t, v)  VER_TYPE_PASTER(t, v)
#define VER_TYPE_PASTER(t, v) t ## _v ## v ## _t

#define VER_FUN(fun, ver)  JOIN(fun ## _v, ver)

#endif // CALIBFILES_H
