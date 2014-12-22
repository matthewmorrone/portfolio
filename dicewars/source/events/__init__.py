#!/usr/bin/env python
#
#Copyright 2006 DR0ID <dr0id@bluewin.ch> http://mypage.bluewin.ch/DR0ID
#
#
#

"""
#TODO: documentation!
#TODO: unittest(s), benchmark!!
"""

__author__    = "$Author: DR0ID $"
__version__   = "$Revision: 144 $"
__date__      = "$Date: 2007-03-18 18:58:25 +0100 (So, 18 Mrz 2007) $"
__license__   = ''
__copyright__ = "DR0ID (c) 2006"


##import eventdispatcher
##import eventenabled
##import rooteventsource

from eventdispatcher import *
from eventenabled import *


##del eventdispatcher
##del eventenabled


try:
    import pygame
    from rooteventsource import *
##    del rooteventsource
except:
    pass

