// /!\ WARNING this function assumes that there is no variable 'A' in the global scope
function R
(
    a,  // the array representing the sudoko grid

        // placeholder arguments
    i,  // index of the last empty cell
    j,  // index to check the candidates for the cell 'i'
    m,  // candidate number for the the cell 'i'
    g   // flag whether 'm' is a already used in the same row|col|node as 'i'
){
    // phase 1: look for an empty cell
    for
    (   
       i=80;   
       a[i];        // keep going if the cell isn't empty
       i--||A       // decrease the index and throw a ReferenceError exception if we went through the whole grid
    );
    // phase 2: check all candidate numbers for the cell 'i'
    for
    (
      m=10;
      g=a[i]=--m;   // put the candidate in the cell 'i' already and set 'g' to something truthy
                    // at the end of phase 2, the cell 'i' is reset to 0 for "higher" branches of the recursion
        g&&R(a)     // recurse if 'm' isn't already used in the same row|col|node as 'i'
   )
      // phase 3: check if the candidate number is used already
      for(j in a)           // loop through the whole grid again
           g*=              // 
               j==i         // keep 'g' as is if we are on the cell 'i'
               ||           // otherwise, turn 'g' falsy if
               a[j]^m       // the cell 'j' is set to 'm'
               ||           // and 'i' and 'j' are in the same row|col|node
               i%9^j%9&&i/9^j/9&&i/27^j/27|i%9/3^j%9/3
}