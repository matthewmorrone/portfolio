#Copyright 2006 DR0ID http://mypage.bluewin.ch/DR0ID
#
#
#
"""
Ordinary dice. Perhaps in future there will be more differen kinds of dices.
"""

__author__  = "$Author: DR0ID $"
__version__ = "$Revision: 100 $"
__date__    = "$Date: 2007-03-13 20:27:02 +0100 (Di, 13 Mrz 2007) $"

import random

class Dice(object):
    """
    An odrinary Dice (sum of opposite pips is always 7).
    """
    
    def __init__(self):
        """
        Inits the dice to an random number of pips.
        """
        object.__init__(self)
        self.state = random.randint(1, 6)
        
    def roll(self):
        """
        roll() -> pips
        Roll the dice.
        """
        self.state = random.randint(1, 6)
        return self.state
    
    
    
def test():
    """
    Dice rolling test if you run this module for its own.
    """
    dist = {}
    dice = Dice()
    numdice = 2
    for i in range(10000):
        pips = 0
        for num in range(numdice):
            pips += dice.roll()
        if not dist.has_key(pips):
            dist[pips] = 1
        else:
            dist[pips] = dist[pips] + 1
            
    keys = dist.keys()
    keys.sort()
    print "rolling", numdice, "Dice:"
    for idx in keys:
        print idx, dist[idx]
        
        
if __name__ == '__main__':
    test()