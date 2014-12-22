/*
NBack, and application that implements dual N-Back training.
Copyright (C) 2008 Erik Mork and Monica Mork
Contact us at: http://www.silverbaylabs.org/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;
using System.Diagnostics;

namespace NBack
{
    /// <summary>
    /// Creates blocks.
    /// </summary>
    public class BlockCreator
    {

        //private static Random Rand = new Random();

        public static Random Rand 
        { get; set; }

        static BlockCreator()
        {
            Rand = new Random();
        }

        /// <summary>
        /// Creates blocks with x targets of each kind (audio and visual with y overlap) with a default block size
        ///  of 20 trials + n (the first n trials aren't used to collect data because there's not enough
        ///  into to ask the user yet).
        /// </summary>
        /// <param name="n">The n in n-back.  How far back does a particular trial match another trial
        ///   to score a hit (be a "target").</param>
        /// <returns></returns>
        public static List<Trial> createBlock(int n)
        {



            //Get a list of targets (positive trials) that should appear in the trials.
            Dictionary<int, TargetKind> targets = getTargets();



            List<Trial> trials = new List<Trial>();

            //The first n trials are completely random (there's nothing to match or not match...)
            for (int i = 0; i < n; i++)
            {
                Trial t = getRandomTrial();
                t.SecondTrialInTarget = TargetKind.TooEarly; //Too early in the list for this trial to have an earlier matching pair.
                trials.Add(t);
            }

            for (int i = n; i < default_Block_Size + n; i++)
            {
                //Get a completely non-matching trial
                Trial trialToAdd = getRandomTrial(trials[i - n]);

                TargetKind matchingKind;
                //Is this trial the 2nd in a target ("matching") pair?  If so,
                // we need to tweak it before we add it so that it matches.
                if (targets.TryGetValue(i - n, out matchingKind) == true)
                {
                    Trial trialAlreadyAdded = trials[i - n];
                    //Set the "matching kind" in the 2nd of the pair that we're adding
                    trialToAdd.SecondTrialInTarget = matchingKind;
                    if (matchingKind == TargetKind.Audio)
                        trialToAdd.Letter = trialAlreadyAdded.Letter;
                    else if (matchingKind == TargetKind.Visual)
                        trialToAdd.Position = trialAlreadyAdded.Position;
                    else if (matchingKind == TargetKind.Both)
                    {
                        trialToAdd.Letter = trialAlreadyAdded.Letter;
                        trialToAdd.Position = trialAlreadyAdded.Position;
                    }



                }

                trials.Add(trialToAdd);
            }






            ////**************************************************************************
            ////Get a completely random Block of trials (random number of targets...)
            //List<Trial> trials = getRandomBlock_NoTargets(n);




            ////Loop through each target and make the second in the target pair match the first.  
            //foreach(KeyValuePair<int, TargetKind> kvp in targets)
            //{

            //    Trial t1 = trials[kvp.Key];
            //    Trial t2 = trials[kvp.Key+n];

            //    //Make sure that there aren't any matches.  That would indicate a previous problem.
            //    Debug.Assert(t1.Letter != t2.Letter);
            //    Debug.Assert(t1.Position != t2.Position);

            //    //Assign the kind of target to the 2nd trial
            //    t2.SecondTrialInTarget = kvp.Value;

            //    //Decide how they should match and match them appropriately by changing the second one
            //    if (kvp.Value == TargetKind.Audio)
            //        t2.Letter = t1.Letter;
            //    else if (kvp.Value == TargetKind.Visual)
            //        t2.Position = t1.Position;
            //    else if (kvp.Value == TargetKind.Both)
            //    {
            //        t2.Letter = t1.Letter;
            //        t2.Position = t1.Position;
            //    }

                
            //}//end loop through each target


            return trials;
        }


        /// <summary>
        /// Get a list of targets ("matching" trials) to insert into the block.  The returned dictionary is
        ///  sorted by the key position.
        /// </summary>
        /// <returns></returns>
        private static Dictionary<int, TargetKind> getTargets()
        {
            Dictionary<int, TargetKind> targets = new Dictionary<int, TargetKind>();

            //Audio targets
            for (int i = 0; i < num_Audio_Targets; i++)
            {
                int iTargetLocation = getRandomTargetLocation(targets);
                targets.Add(iTargetLocation, TargetKind.Audio);
            }

            //Visual targets
            for (int i = 0; i < num_Visual_Targets; i++)
            {
                int iTargetLocation = getRandomTargetLocation(targets);
                targets.Add(iTargetLocation, TargetKind.Visual);
            }

            //Both targets
            for (int i = 0; i < num_Both_Targets; i++)
            {
                int iTargetLocation = getRandomTargetLocation(targets);
                targets.Add(iTargetLocation, TargetKind.Both);
            }

            //Sort the targets so they're all in order
            //targets.
            targets = sortDictionary(targets);


            return targets;
        }

        private static Dictionary<int, TargetKind> sortDictionary(Dictionary<int, TargetKind> targets)
        {
            List<KeyValuePair<int, TargetKind>> keyAndValueList = new List<KeyValuePair<int, TargetKind>>();

            foreach (KeyValuePair<int, TargetKind> kvp in targets)
                keyAndValueList.Add(kvp);

            keyAndValueList.Sort(compareKVP);

            Dictionary<int, TargetKind> newDictionary = new Dictionary<int, TargetKind>();

            foreach (KeyValuePair<int, TargetKind> kvp in keyAndValueList)
                newDictionary.Add(kvp.Key, kvp.Value);

            return newDictionary;
        }

        private static int compareKVP(KeyValuePair<int, TargetKind> kvp1, KeyValuePair<int, TargetKind> kvp2)
        {
            //Debug.Assert(kvp1 != null);
            //Debug.Assert(kvp2 != null);

            if (kvp1.Key < kvp2.Key)
                return -1;
            else if (kvp1.Key > kvp2.Key)
                return 1;
            else
                return 0;
        }


        /// <summary>
        /// Hand back a target location that isn't already used in the list of targets (in the list, the
        ///  key is the target locations).  Will only choose the first trial that will consists of the pair that forms a "target".
        ///  The first of the pair can appear in locations 0 to default_Block_Size.
        /// </summary>
        /// <returns></returns>
        private static int getRandomTargetLocation(Dictionary<int, TargetKind> targets)
        {
            int iLocation=0;
            do
            {
                //Gives 0 to default_Block_Size-1 which is a perfect index into all possible iLocation(s)
                iLocation = Rand.Next(default_Block_Size);


                TargetKind k;

                //if this value is already used, just stay in the loop.
                if (targets.TryGetValue(iLocation, out k) == false)
                    break;

            } while (true);

            return iLocation;
        }


 

        //Get a random trial that doesn't match (either audio or visual) the passed-in trial
        private static Trial getRandomTrial(Trial noMatch)
        {
            SquarePosition s;
            Consonant c ;
            
            do
            {
                s = (SquarePosition)Rand.Next((int)SquarePosition.MiddleLeft+1);
                if(s!=noMatch.Position)
                    break;

            }while(true);

            do
            {
               c = (Consonant)Rand.Next((int)Consonant.Letter8+1);
               if (c != noMatch.Letter)
                   break;
            } while (true);

            
           
            Trial t = new Trial(s, c);
            return t;
        }



        //Get a completely random trial that 
        private static Trial getRandomTrial()
        {

            SquarePosition s = (SquarePosition)Rand.Next((int)SquarePosition.MiddleLeft + 1);
            Consonant c = (Consonant)Rand.Next((int)Consonant.Letter8 + 1);
            Trial t = new Trial(s, c);
            return t;
        }

        public static readonly int default_Block_Size = 20;
        public static readonly int num_Blocks_Total = 20;
        private static readonly int num_Audio_Targets = 4;
        private static readonly int num_Visual_Targets = 4;
        private static readonly int num_Both_Targets = 2;
        

        //public static int TotalVisualTargets
        //{
        //    get { return num_Visual_Targets + num_Both_Targets; }
        //}


        //public static int TotalAudioTargets
        //{
        //    get { return num_Audio_Targets + num_Both_Targets; }
        //}
    }



}
