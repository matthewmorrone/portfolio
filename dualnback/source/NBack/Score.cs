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
    public enum TrialResult
    {
        Audio_Success,
        Audio_Failure,
        Visual_Success,
        Visual_Failure
    }

    /// <summary>
    /// Class responsible for keeping track of the user's score.
    /// </summary>
    public class Score
    {
        //public delegate void HandleScoreEvent();
        public delegate void handleTrialResult(TrialResult result);
        public delegate void HandleLatestScores(int totalCorrect, int totalScore);

        private TargetKind _target= TargetKind.None;

        /// <summary>
        /// Value of n that is conveniently stored in this object.
        /// </summary>
        private int _n=0;



        //public event HandleScoreEvent OnCorrectAnswer;
        //public event HandleScoreEvent OnIncorrectAnswer;
        public event handleTrialResult HandleTrialOutcome;
        public event HandleLatestScores HandleScores;


        /// <summary>
        /// Start a new trial and give the correct answer.
        /// </summary>
        /// <param name="correctAnswer"></param>
        public void startNewTrial(TargetKind correctAnswer)
        {
            _target = correctAnswer;
        }

        /// <summary>
        /// The user has mashed a button.
        /// </summary>
        /// <param name="guess"></param>
        public void recordButtonPress(Key guess)
        {

            switch (guess)
            {
                //A is pressed for visual per protocol
                case Key.A:
                    if (_visualKeyPressed == true)
                        return;
                    if ((_target == TargetKind.Visual) || (_target == TargetKind.Both))
                        HandleTrialOutcome(TrialResult.Visual_Success);
                    else
                        HandleTrialOutcome(TrialResult.Visual_Failure);
                    _visualKeyPressed = true;
                    break;
                //L is pressed for audio targets per protocol
                case Key.L:
                    if (_audioKeyPressed == true)
                        return;
                    if ((_target == TargetKind.Audio) || (_target == TargetKind.Both))
                        HandleTrialOutcome(TrialResult.Audio_Success);
                    else
                        HandleTrialOutcome(TrialResult.Audio_Failure);
                    _audioKeyPressed = true;
                    break;
            }
        }

        public void endTrial()
        {

            //Ignore any key presses that come early in the list (before a pair could exist)...
            if (_target == TargetKind.TooEarly)
            {
                //Clear the members.
                _target = TargetKind.None;
                _audioKeyPressed = false;
                _visualKeyPressed = false;

                return;
            }



            //Set to true if the user got a trial completely correct.
            bool correctTrial = false;

            if (_target == TargetKind.None)
            {
                if (_audioKeyPressed)
                    _audioMistakesPerBlock++;
                if (_visualKeyPressed)
                    _visualMistakesPerBlock++;

                if ((_audioKeyPressed == false) && (_visualKeyPressed == false))
                    correctTrial = true;
            }
            else if (_target == TargetKind.Both)
            {
                if (_audioKeyPressed != true)
                    _audioMistakesPerBlock++;
                if (_visualKeyPressed != true)
                    _visualMistakesPerBlock++;

                if ((_audioKeyPressed == true) || (_visualKeyPressed == true))
                    correctTrial = true;
            }
            else if (_target == TargetKind.Audio)
            {
                if (_audioKeyPressed != true)
                {
                    //User didn't press audio key
                    _audioMistakesPerBlock++;
                    //failureEvent();
                }
                if (_visualKeyPressed == true)
                    _visualMistakesPerBlock++;

                if ((_audioKeyPressed == true) && (_visualKeyPressed != true))
                    correctTrial = true;

            }
            else if (_target == TargetKind.Visual)
            {
                if (_audioKeyPressed == true)
                    _audioMistakesPerBlock++;
                if (_visualKeyPressed != true)
                {
                    //User didn't press the visual key
                    _visualMistakesPerBlock++;
                    //failureEvent();
                }

                if ((_audioKeyPressed != true) && (_visualKeyPressed == true))
                    correctTrial = true;
            }

            if (correctTrial == true)
            {
                _TotalCorrect++;
                _score = _score + _n;
            }

            //Update any subscribers with the most up to date info:
            HandleScores(_TotalCorrect, _score);

            //Clear the members.
            _target = TargetKind.None;
            _audioKeyPressed = false;
            _visualKeyPressed = false;
        }

        ///// <summary>
        ///// The user did something right.
        ///// </summary>
        //private void successEvent()
        //{
        //    _score++;
        //    OnCorrectAnswer();
        //}

        ///// <summary>
        ///// The user did something wrong.
        ///// </summary>
        //private void failureEvent()
        //{
        //    OnIncorrectAnswer();
        //}

        /// <summary>
        /// Called when a block is started.
        /// </summary>
        public void startBlock(int n)
        {
            _n = n;
            _nValues.Add(n);

            _audioMistakesPerBlock = 0;
            _visualMistakesPerBlock = 0;
            _target = TargetKind.None;
            //Clear the button press flags.
            _audioKeyPressed = false;
            _visualKeyPressed = false;
        }

        /// <summary>
        /// List of all N values that have been fed to "startBlock"
        /// </summary>
        private List<int> _nValues = new List<int>();

        /// <summary>
        /// Get the average N value so far.
        /// </summary>
        /// <returns></returns>
        public double getMeanN()
        {
            if (_nValues.Count < 1)
                return 0;

            double meanN=0;
            foreach (int i in _nValues)
                meanN += (double)i;

            return (meanN / (double)_nValues.Count);
        }

        /// <summary>
        /// Calculate a very rough increase in gF based on the scores.  Tie Mean-N to days of training and then tie that to
        ///  gF increase.  Very rough.
        /// </summary>
        /// <returns></returns>
        public double getPercentGFIncrease()
        {
            double increase = 0;

            //Compute number of days.
            //y = .1073x + 3.0951
            // Found by using linear regession tool here: http://www.xuru.org/rt/LR.asp#CopyPaste with estimated data from figure 2 in the paper.
            try
            {

                double meanN = getMeanN();
                double days = (meanN - 3.0951) / .1073;

                //Compute gF increase from an assumed initial average of 9.5 (see figure 3).  This is the number of solved problems in a 10 minute span.
                //Again, used regression tool http://www.xuru.org/rt/LR.asp#CopyPaste.  And used data from figure 3b.
                // Calculated regression is y= .3973x + -3.212

                double increaseInGFScore = (days * .3973) - 3.212;

                increase = 100 * (increaseInGFScore / 9.5);
            }
            catch
            {}


            //If someone scored below average on their first trial or whatever, don't 
            // report a negative value.
            if (increase < 0)
                return 0;
            else
                return increase;
        }

        /// <summary>
        /// Called at the end of a Block
        /// </summary>
        /// <returns>-1 if n should be decreased by 1, 1 if n should be increased by 1 and 0 if n shouldn't change</returns>
        public int endBlock()
        {
            int deltaN = 0;
            //Increase N if more than 3 mistakes per "modality" (see protocol)
            if((_audioMistakesPerBlock<3)&&(_visualMistakesPerBlock<3))
                deltaN = 1;
            else if((_audioMistakesPerBlock+_visualMistakesPerBlock)>5)
                deltaN = -1;


            _audioMistakesPerBlock = 0;
            _visualMistakesPerBlock = 0;
            _target = TargetKind.None;
            //Clear the button press flags.
            _audioKeyPressed = false;
            _visualKeyPressed = false;

            return deltaN;
        }

        public int audioMistakes { get { return _audioMistakesPerBlock; } }
        public int visualMistakes { get { return _visualMistakesPerBlock; } }


        /// <summary>
        /// Set to true whenever the audio key is pressed during a trial.
        /// </summary>
        private bool _audioKeyPressed = false;

        /// <summary>
        /// Set to true whenever the visual key is pressed during a trial.
        /// </summary>
        private bool _visualKeyPressed = false;

        private int _audioMistakesPerBlock = 0;
        private int _visualMistakesPerBlock = 0;

        private int _score = 0;

        /// <summary>
        /// The total number of correct trials.
        /// </summary>
        private int _TotalCorrect = 0;

    }
}