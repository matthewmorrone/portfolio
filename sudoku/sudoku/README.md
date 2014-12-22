Sudoku Solver in 140 bytes
=========

Solve a Sudoku grid only using magic, recursion, and 140bytes of brute force.

This entry was inspired and built on top of the itsy bitsy shoulders of the smallest sudoku solvers in Perl (120b), Ruby (122b), Python (178b), ... 
 
Credits go this way:

    166b @p01 .......... initial implementation
    147b @p01 .......... initial golf
    146b @qfox ......... loop optimization
    145b @qfox ......... output with closured callback
    140b @p01 .......... output with hijacked Array.prototype.toString()
    141b @maksverver ... fixed the glitchy j^i==j test
    140b @fgnass ....... ReferenceError exit trick + cross browser fix

Thanks to everyone who helped golf and fix this puppy.