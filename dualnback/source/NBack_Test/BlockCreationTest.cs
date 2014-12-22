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
using Microsoft.Silverlight.Testing;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NBack;
using System.Collections.Generic;

namespace NBack_Test
{
    [TestClass]
    public class BlockCreationTest
    {
        [TestMethod]
        public void simpleBlocks()
        {
            BlockCreator.Rand = new Random(50023);
            List<Trial> trials =  BlockCreator.createBlock(2);
            validateBlock(trials, 2, 22, 4, 4, 2);


            List<Trial> trials2 = BlockCreator.createBlock(5);
            validateBlock(trials2, 5, 25, 4, 4, 2);
        }

        [TestMethod]
        public void multipleBlocks()
        {
            for (int i = 0; i < 20; i++)
            {
                BlockCreator.Rand = new Random(101 + i);

                List<Trial> trials = BlockCreator.createBlock(3);
                validateBlock(trials, 3, 23, 4, 4, 2);
            }
        }


        private void validateBlock(List<Trial> trials, int n, int ExpectedTrials, int Audio, int Visual, int Both)
        {
            Assert.IsTrue(trials.Count == ExpectedTrials, "incorrect number of trials");
            int actualAudio=0, actualVisual=0, actualBoth=0;

            for (int i = 0; i < trials.Count; i++)
            {
                if (i < n)
                {
                    Assert.IsTrue(trials[i].SecondTrialInTarget == TargetKind.TooEarly, "Early trials in list aren't marked with 'too early' flag.");
                }

                //If we're past the initial couple...
                if (i >= n)
                {
                    Trial t1 = trials[i - n];
                    Trial t2 = trials[i];

                    //Both match...
                    if ((t1.Letter == t2.Letter) && (t1.Position == t2.Position))
                    {
                        actualBoth++;
                        Assert.IsTrue(t2.SecondTrialInTarget == TargetKind.Both, String.Format("2nd trial in target isn't set to Both in item number {0}", i));
                    }
                    else if (t1.Letter == t2.Letter)
                    {
                        actualAudio++;
                        Assert.IsTrue(t2.SecondTrialInTarget == TargetKind.Audio, String.Format("2nd trial in target isn't set to Audio in item number {0}", i));
                    }
                    else if (t1.Position == t2.Position)
                    {
                        actualVisual++;
                        Assert.IsTrue(t2.SecondTrialInTarget == TargetKind.Visual, String.Format("2nd trial in target isn't set to Visual in item number {0}", i));
                    }
                    else
                    {
                        Assert.IsTrue(t2.SecondTrialInTarget == TargetKind.None, "Isn't a target but the SecondTrialInTarget is set as if it is one...");
                    }
                }
            }

            Assert.IsTrue(Audio == actualAudio, "incorrect number of audio targets");
            Assert.IsTrue(Visual == actualVisual, "incorrect number of visual targets");
            Assert.IsTrue(Both == actualBoth, "incorrect number of Both targets");

        }

    }
}
