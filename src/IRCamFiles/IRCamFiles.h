/**
 * @file IRCamFiles.h
 * Camera files utilities.
 *
 * This file defines camera file utilities.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (mer., 06 juil. 2016) $
 * $Id: IRCamFiles.h 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/IRCamFiles.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef IRCAMFILES_H
#define IRCAMFILES_H

#include "utils.h"

#define CALIBFILES_VERSION    2

#define TSBLFILES_VERSION     CALIBFILES_VERSION
#define TSCOFILES_VERSION     CALIBFILES_VERSION
#define TSDVFILES_VERSION     2
#define TSFSFILES_VERSION     2
#define TSICFILES_VERSION     CALIBFILES_VERSION

#define VER_MACRO(m, v) JOIN(m ## _V, v)

#define VER_TYPE(t, v)  VER_TYPE_PASTER(t, v)
#define VER_TYPE_PASTER(t, v) t ## _v ## v ## _t

#define VER_DEFAULT(d, v)  VER_DEFAULT_PASTER(d, v)
#define VER_DEFAULT_PASTER(d, v) d ## _v ## v ## _default

#define VER_FUN(fun, ver)  JOIN(fun ## _v, ver)

#endif // IRCAMFILES_H
