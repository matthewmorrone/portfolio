#!/usr/bin/env python
#
#Copyright 2006 DR0ID <dr0id@bluewin.ch> http://mypage.bluewin.ch/DR0ID
#
#
#

"""
Eventendabled module provide a class for subclassing. Any class that is 
derived from this class should be able to process events.

#TODO: perhaps remove the use of reg_event_func() and remove_event_func(), only
register eventtypes and handle them in the handle_event(), because you have to
inherit anyway, so you can overwrite it (because its faster, function call 
overhead)!!

cons: more flexible now, allows adding event handling funcitons at runtime



"""

__author__    = "$Author: XereX $"
__version__   = "$Revision: 172 $"
__date__      = "$Date: 2010-03-20 22:02:09 +0100 (Sa, 20 Mrz 2010) $"
__license__   = ''
__copyright__ = "DR0ID (c) 2006"

import pygame

class EventEnabled(object):
    """
    Any class derived from that is enabled for event registering and 
    processing.
    """
    def __init__(self):
        object.__init__(self)
        self._eventmap = {} # {eventtype:handle_eventtype}
        self.parent = None
        
    def get_eventtypes(self): # ->[eventtypes]
        """
        Returns the eventtypes this Object need to listen.
        """
        return self._eventmap.keys()
        
    def handle_event(self, event):
        """
        Dispatches the even to the function to handle it.
        """
        etype = event.type
        if etype == pygame.USEREVENT:
            etype = event.usertype
        if self._eventmap.has_key(etype):
            if self.on_event(event):
                return True
            if self._eventmap[etype](event):
                return True
            return self.on_afterevent(event)
        return False
    
    def on_event(self, event):
        """
        Is called before the event is dispatch to the registered functions
        If this method returns True then the event isnt dipatched furder. 
        Returning False would do so.
        """
        return False
    
    def on_afterevent(self, event):
        """
        It is only called if none of the registered listeners could handle the 
        event.
        """
        return False
    
    def reg_event_func(self, eventtype, func): # func(event)->bool
        """
        For each eventtype a function can be registered. When a event of 
        the registered eventtype is passed, the funciton will be called:
        func(event)->bool   True means event handeld, stop dispatching it
                            False is, not procces
                            If in doubt what to return, return False.
        """
        self._eventmap[eventtype] = func
        if self.parent:
            self.parent.add_listener(self, eventtype)
        
    def unreg_event_func(self, eventtype=None):
        """
        Unregister an previously registered function for a eventtype
        """
        try:
            del self._eventmap[eventtype]
            if self.parent:
                self.parent.remove_listener(self, eventtype)
        except KeyError:
            pass




    
    
    
