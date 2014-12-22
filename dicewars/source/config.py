#!/usr/bin/env python
#
#Copyright 2006 DR0ID <dr0id@bluewin.ch> http://mypage.bluewin.ch/DR0ID
#
#
#

"""
#TODO: documentation!
"""

__author__    = "$Author: DR0ID $"
__version__   = "$Revision: 158 $"
__date__      = "$Date: 2007-04-10 17:46:23 +0200 (Di, 10 Apr 2007) $"
__license__   = ''
__copyright__ = "DR0ID (c) 2007"




# general info
VERSION = __version__
# TODO: perhaps also platform info?


# graphics
screen_width  = 800
screen_height = 600
flags = None # not used at the moment, or better each option seperate?
frames_per_sec = 30


# needed by gamelogic in Multigame and Singlegame
single_player = True
# TODO: these two must be set in Multivote or in Singleoptions
players = [] # [player]
world = None

