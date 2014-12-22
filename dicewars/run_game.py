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
__version__   = "$Revision: 167 $"
__date__      = "$Date: 2007-04-10 18:17:40 +0200 (Di, 10 Apr 2007) $"
__license__   = ''
__copyright__ = "DR0ID (c) 2007"


import sys
import os
try:
    path_main = os.path.abspath(os.path.join(os.path.dirname(__file__), 'source'))
    sys.path.insert(0, path_main)
    os.chdir(path_main)
except:
    pass
    
import singleoptions

if '-profile' in sys.argv:
    import profile
    profile.run('singleoptions.main()')
else:
    singleoptions.main()

