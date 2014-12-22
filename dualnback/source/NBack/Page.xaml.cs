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
using System.Windows.Browser;
using System.Resources;
using System.Reflection;

namespace NBack
{
    [ScriptableType]
	public partial class Page : UserControl
	{
        /// <summary>
        /// A timer to wait after the "continue" button has been pushed.
        /// </summary>
        private Storyboard _continueTimer = new Storyboard();

		public Page()
		{
			// Required to initialize variables
			InitializeComponent();
            HtmlPage.RegisterScriptableObject("NBackDisplay", this);



            ShowN.DisplayN(_starting_N);
            square.Opacity = 0;
            ProgBar.setProgress(0);
            DemoTimer.Completed += new EventHandler(demoStepEnded);
            InitialWait.Completed += new EventHandler(Start_Training);
            InitialWait.Duration = new TimeSpan(675 * 10000);//675ms
            _continueTimer.Completed += new EventHandler(startBlock);
            _continueTimer.Duration = new TimeSpan(675 * 10000);//675ms

            


		}



        public void done(object sender, EventArgs e)
        {
            this.FadeIn.Begin();
        }

        //public void timerCallback(object o)
        //{
        //    this.FadeIn.Begin();
        //    this.PlayingSurface.InvalidateArrange();
        //}



        private void PauseButton_Click(object sender, RoutedEventArgs e)
        {
            //Pause all animations/timers
            Timer_1.Pause();
            FadeBoxOut.Pause();
            TrialTimer.Pause();

            //AudioTargetsText_2.Text = String.Format("{0}/{1}", BlockCreator.default_Block_Size - _score.audioMistakes, BlockCreator.default_Block_Size);
            //VisualTargetsText_2.Text = String.Format("{0}/{1}", BlockCreator.default_Block_Size - _score.visualMistakes, BlockCreator.default_Block_Size);




            //Position pop-ups
            GeneralTransform gt = PopupTarget.TransformToVisual(Application.Current.RootVisual as UIElement);
            Point offset = gt.Transform(new Point(0, 0));
            PausePopup.HorizontalOffset = offset.X;
            PausePopup.VerticalOffset = offset.Y;

            PausePopup.IsOpen = true;


            StartButton.Click -= PauseButton_Click;
            StartButton.Content = "Continue";
            StartButton.Click += continueButton_Click;


        }

        /// <summary>
        /// Continue from pause.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void continueButton_Click(object sender, RoutedEventArgs e)
        {

            StartButton.Click -= continueButton_Click;
            StartButton.Content = "Pause";
            StartButton.Click += PauseButton_Click;

            PausePopup.IsOpen = false;
            Timer_1.Resume();
            FadeBoxOut.Resume();
            TrialTimer.Resume();

        }


        private void StartButton_Click(object sender, RoutedEventArgs e)
        {
            //change the start button into a pause button.
            StartButton.Click -= StartButton_Click;
            StartButton.Content = "Pause";
            StartButton.Click += PauseButton_Click;

            //Start our timer which calls back to start the application.
            InitialWait.Begin();
        }

        /// <summary>
        /// Kick off the entire training session.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Start_Training(object sender, EventArgs e)
        {
            _playingGame = true;


            //Set the stimulus fade-out timer
            this.Timer_1.Duration = new Duration(new TimeSpan(_stimulus_time * 10000));
            this.Timer_1.Completed += new EventHandler(hideStimulus);

            //Set the trial time-out timer
            TrialTimer.Duration = new Duration(new TimeSpan(_total_trial_time * 10000));
            TrialTimer.Completed += new EventHandler(trialTimeUp);




            _score = new Score();
            _score.HandleTrialOutcome += handleTrialResult;
            _score.HandleScores += handleScores;

            //We're starting.  Get the list of trials and clear the extra stuff
            _n = _starting_N;
            _blockNum = 0;
            _trialNum = 0;
            m_Trials = BlockCreator.createBlock(_n);
            _score.startBlock(_n);



            //Present the first trial to the user
            presentTrialInfoToUser(m_Trials[_trialNum]);
            _score.startNewTrial(m_Trials[_trialNum].SecondTrialInTarget);


            //Start the timers for the first trial
            this.Timer_1.Begin();
            TrialTimer.Begin();
        }

        /// <summary>
        /// Called via an event to say if there was a trial success or failure or what...
        /// </summary>
        /// <param name="result"></param>
        void handleTrialResult(TrialResult result)
        {
            if (result == TrialResult.Visual_Success)
                Left_Success.Begin();
            else if (result == TrialResult.Visual_Failure)
                Left_Failure.Begin();
            if (result == TrialResult.Audio_Success)
                Right_Success.Begin();
            else if (result == TrialResult.Audio_Failure)
                Right_Failure.Begin();
        }

        private void Reset_Click(object sender, RoutedEventArgs e)
        {
            StartButton.Content = Page_Resources.Start_Button;
            StartButton.Click -= Reset_Click;
            StartButton.Click += StartButton_Click;
            FadeHelpBoxOut.Begin();

            _blockNum = 0;
            _playingGame = false;
            _trialNum = 0;
            _n = _starting_N;
            //LayoutRoot.InvalidateArrange();

            SessionText.Text = String.Format("{0}/{1}", _blockNum, BlockCreator.default_Block_Size);
            //NumberCorrectText.Text = 0.ToString();
            ScoreText.Text = 0.ToString() ;
            //NText.Text = _n.ToString();
        }

        /// <summary>
        /// Called whenever the total time for an individual trial has expired.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void trialTimeUp(object sender, EventArgs e)
        {



            Debug.Assert(m_Trials!=null, "empty trials list at the end of a trial...");

            _score.endTrial();
            _trialNum++;

            double progress = (double)_trialNum / (double)m_Trials.Count;
            ProgBar.setProgress(progress*100);



            //Are we at the end of a block?
            if (_trialNum >= m_Trials.Count)
            {

                //Are we at the end of an entire session (20 blocks, the _blocknum hasn't been incremented yet)?
                if(_blockNum==(BlockCreator.num_Blocks_Total-1))
                {
                    HelpText.Text = Page_Resources.Completed_All;
                    //What was the average n level?
                    string averageN = String.Format(Page_Resources.Mean_N, _score.getMeanN().ToString("F2"));
                    HelpText.Text += averageN;
                    if (_score.getPercentGFIncrease() > 0)
                    {
                        string gFIncrease = String.Format(Page_Resources.Increase_GF, _score.getPercentGFIncrease().ToString("F2"));
                        HelpText.Text += gFIncrease;
                    }

                    FadeInHelpBox.Begin();
                    StartButton.Content = Page_Resources.Reset__Button;
                    StartButton.Click -= StartButton_Click;
                    StartButton.Click -= PauseButton_Click;
                    StartButton.Click += Reset_Click;
                    return;

                }

                //End the block
                AudioTargetsText.Text = String.Format("{0}/{1}", BlockCreator.default_Block_Size-_score.audioMistakes,BlockCreator.default_Block_Size);
                VisualTargetsText.Text = String.Format("{0}/{1}", BlockCreator.default_Block_Size - _score.visualMistakes, BlockCreator.default_Block_Size);
                int deltaN = _score.endBlock();
                if ((deltaN + _n) >= 2)
                    _n = _n + deltaN;
                //NText.Text = _n.ToString();


                //Display the dialog
                NumberBack.Text = _n.ToString();


                //Position pop-ups
                GeneralTransform gt = PopupTarget.TransformToVisual(Application.Current.RootVisual as UIElement);
                Point offset = gt.Transform(new Point(0, 0));
                EndBlockPopup.HorizontalOffset = offset.X;
                EndBlockPopup.VerticalOffset = offset.Y;
                EndBlockPopup.IsOpen = true;
                return;

            }
   

            //Start a new trial
            Debug.Assert(_trialNum < m_Trials.Count, "Trying to do more trials than there are in this block...");
            _score.startNewTrial(m_Trials[_trialNum].SecondTrialInTarget);
            presentTrialInfoToUser(m_Trials[_trialNum]);

            Timer_1.Begin();
            TrialTimer.Begin();
        }



        /// <summary>
        /// Callback for when the timer expires for the stimulus.  Hide the stimulus.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void hideStimulus(object sender, EventArgs e)
        {
            FadeBoxOut.Begin();


        }

        /// <summary>
        /// Display trial information (square, audio, etc.) to the user
        /// </summary>
        /// <param name="t"></param>
        private void presentTrialInfoToUser(Trial t)
        {

            ////Play the consonant
            ////AudioPlayer.Play();
            //Debug.Assert(AudioPlayer.Markers.Count == 8);

            //TimeSpan ts;
            ////switch (t.Letter)
            ////{
            ////    case Consonant.B:
            ////        break;
            ////}

            //TimelineMarker tm = AudioPlayer.Markers[(int)t.Letter];
            //AudioPlayer.Position = tm.Time;
            //AudioPlayer.Play();

            //AudioPlayer_B.Position = TimeSpan.FromMilliseconds(0);
            //AudioPlayer_B.Play();
            switch (t.Letter)
            {
                case Consonant.Letter1:
                    AudioPlayer_1.Play();
                    break;
                case Consonant.Letter2:
                    AudioPlayer_2.Play();
                    break;
                case Consonant.Letter3:
                    AudioPlayer_3.Play();
                    break;
                case Consonant.Letter4:
                    AudioPlayer_4.Play();
                    break;
                case Consonant.Letter5:
                    AudioPlayer_5.Play();
                    break;
                case Consonant.Letter6:
                    AudioPlayer_6.Play();
                    break;
                case Consonant.Letter7:
                    AudioPlayer_7.Play();
                    break;
                case Consonant.Letter8:
                    AudioPlayer_8.Play();
                    break;
                default:
                    Debug.Assert(false, "Asked to play an incorrect sound.");
                    break;
            }
            //AudioPlayer.Markers[0].Time;


            //Display the visual information
            int iColumn = 0;
            int iRow = 0;
            switch (t.Position)
            {
                case SquarePosition.BottomLeft:
                    iColumn = 0;
                    iRow = 2;
                    break;
                case SquarePosition.BottomMiddle:
                    iColumn = 1;
                    iRow = 2;
                    break;
                case SquarePosition.BottomRight:
                    iColumn = 2;
                    iRow = 2;
                    break;
                case SquarePosition.MiddleLeft:
                    iColumn = 0;
                    iRow = 1;
                    break;
                case SquarePosition.MiddleRight:
                    iColumn = 2;
                    iRow = 1;
                    break;
                case SquarePosition.TopLeft:
                    iColumn = 0;
                    iRow = 0;
                    break;
                case SquarePosition.TopMiddle:
                    iColumn = 1;
                    iRow = 0;
                    break;
                case SquarePosition.TopRight:
                    iColumn = 2;
                    iRow = 0;
                    break;
                default:
                    Debug.Assert(false, "An unrecognized position was used.");
                    break;
            }

            square.SetValue(Grid.RowProperty, iRow);
            square.SetValue(Grid.ColumnProperty, iColumn);
            PlayingSurface.InvalidateArrange();
            FadeIn.Begin();
        }



        /// <summary>
        /// Our list of trials
        /// </summary>
        private List<Trial> m_Trials;
        /// <summary>
        /// Value of n for the current block
        /// </summary>
        private int _n = _starting_N;

        /// <summary>
        /// Current block we're working on
        /// </summary>
        private int _blockNum = 0;

        /// <summary>
        /// Current trial we're on.
        /// </summary>
        private int _trialNum = 0;

        /// <summary>
        /// Starting value of n
        /// </summary>
        private const int _starting_N=2;

        private const int _stimulus_time = 500;
        /// <summary>
        /// Total time to wait for user input.
        /// </summary>
        private const int _total_trial_time = 3000;

        /// <summary>
        /// Keeps track of the user's score.
        /// </summary>
        private Score _score = new Score();

        private void UserControl_KeyDown(object sender, KeyEventArgs e)
        {
            if (_playingGame == true)
                _score.recordButtonPress(e.Key);

        }

        private void UserControl_LostFocus(object sender, RoutedEventArgs e)
        {
            object o = e.Source;
        }


        private void startBlock(object sender, EventArgs e)
        {


            //Start a new trial
            Debug.Assert(_trialNum < m_Trials.Count, "Trying to do more trials than there are in this block...");
            _score.startNewTrial(m_Trials[_trialNum].SecondTrialInTarget);
            presentTrialInfoToUser(m_Trials[_trialNum]);

            Timer_1.Seek(new TimeSpan(0));
            TrialTimer.Seek(new TimeSpan(0));
            Timer_1.Begin();
            TrialTimer.Begin();
        }

        private void ContinueButton_Click(object sender, RoutedEventArgs e)
        {
            EndBlockPopup.IsOpen = false;

            //Start a new block...
            ProgBar.setProgress(0);
            _blockNum++;
            SessionText.Text = String.Format("{0}/{1}", _blockNum+1, BlockCreator.default_Block_Size);

            m_Trials = BlockCreator.createBlock(_n);
            _trialNum = 0;

            //Tell the user the n they're using
            ShowN.DisplayN(_n);

            _score.startBlock(_n);

            //Make sure that the media players are stopped.
            AudioPlayer_1.Stop();
            AudioPlayer_2.Stop();
            AudioPlayer_3.Stop();
            AudioPlayer_4.Stop();
            AudioPlayer_5.Stop();
            AudioPlayer_6.Stop();
            AudioPlayer_7.Stop();
            AudioPlayer_8.Stop();

            //Give the user a chance to catch their breath before starting the next block.
            _continueTimer.Begin();

        }

        //Reset whatever audio is calling us...
        private void AudioPlayer_MediaEnded(object sender, RoutedEventArgs e)
        {
            MediaElement m = (MediaElement)sender;
            m.Stop();
            m.Position = TimeSpan.FromMilliseconds(0);
            //m.Pause();
        }


        private void handleScores(int totalCorrect, int totalScore)
        {
            //NumberCorrectText.Text = totalCorrect.ToString();
            ScoreText.Text = totalScore.ToString();
        }


        private bool _displayingDemo = false;
        /// <summary>
        /// Set to true whenever the game is running.
        /// </summary>
        private bool _playingGame = false;


        /// <summary>
        /// Start the demo of how to use the app.
        /// </summary>
        [ScriptableMember]
        public void startDemo()
        {
            if (_playingGame == true)
                return;

            if (_displayingDemo == true)
                return;
            _displayingDemo = true;

            demoSteps = demoStep();
            StartButton.Click-= StartButton_Click;
            StartButton.Click+= StopDemo_Click;
            StartButton.Content = Page_Resources.Stop_Button;
            FadeInHelpBox.Completed += demoStepEnded;
            FadeHelpBoxOut.Completed += demoStepEnded;
            FadeHelpTextOut.Completed += demoStepEnded;
            FadeHelpTextIn.Completed += demoStepEnded;



            nextDemoStep();
        }


        private void StopDemo_Click(object sender, RoutedEventArgs e)
        {
            stopDemo();
        }

        private void stopDemo()
        {
            PlayingSurface.ShowGridLines = false;
            ArrowPopup.IsOpen = false;
            HelpText.Opacity = 0;
            square.Opacity = 0;
            HelpTextControl.Opacity = 0;

            //Return the start button to its proper state
            StartButton.Click -= StopDemo_Click;
            StartButton.Click += StartButton_Click;
            StartButton.Content = Page_Resources.Start_Button;


            FadeInHelpBox.Completed -= demoStepEnded;
            FadeHelpBoxOut.Completed -= demoStepEnded;
            FadeHelpTextOut.Completed -= demoStepEnded;
            FadeHelpTextIn.Completed -= demoStepEnded;

            //DemoTimer.Completed -= nextDemoStep;
            _displayingDemo = false;
        }

        IEnumerator<int> demoSteps = null;

        /// <summary>
        /// Call this to execute the next demo step
        /// </summary>
        private void nextDemoStep()
        {

            if (demoSteps.MoveNext() == true)
            {
            }
            else
            {
                stopDemo();
            }

        }

        /// <summary>
        /// Use yield statements to perform, incrementally, the demo Steps
        /// </summary>
        /// <returns></returns>
        private IEnumerator<int> demoStep()
        {
            

            //Turn your speakers on
            HelpText.Text = HelpText.Text = Page_Resources.Speakers_On;
            FadeInHelpBox.Begin();
            yield return 0;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 3);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            yield return 0;


            //Notice the number
            HelpText.Text = Page_Resources.Notice_NBack_Num;
            GeneralTransform gt = ShowN.TransformToVisual(Application.Current.RootVisual as UIElement);
            Point offset = gt.Transform(new Point(0, 0));
            ArrowPopup.HorizontalOffset = offset.X+55;
            ArrowPopup.VerticalOffset = offset.Y+30;
            //turn on arrow
            ArrowPopup.IsOpen = true;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            yield return 0;

            //This number tells you what to remember X times ago
            HelpText.Text = Page_Resources.NBack_Num_Tells_You;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new Duration(new TimeSpan(0, 0, 8));
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            ArrowPopup.IsOpen = false;
            yield return 0;

            //Watch and listen what happens
            HelpText.Text = Page_Resources.Watch_First_Trial;
            FadeHelpTextIn.Begin();
            PlayingSurface.ShowGridLines = true;
            yield return 0;
            //DemoTimer.Seek(new TimeSpan(0));
            DemoTimer.Duration = new Duration(new TimeSpan(0, 0, 3));
            DemoTimer.Begin();
            yield return 0;
            square.SetValue(Grid.RowProperty, 0);
            square.SetValue(Grid.ColumnProperty, 0);
            PlayingSurface.InvalidateArrange();
            FadeIn.Begin();
            AudioPlayer_1.Position = new TimeSpan(0);
            AudioPlayer_1.Play();

            DemoTimer.Duration = new TimeSpan(0, 0, 2);
            DemoTimer.Begin();
            yield return 0;
            DemoTimer.Begin();
            yield return 0;
            FadeBoxOut.Begin();
            FadeHelpTextOut.Begin();
            yield return 0;

            //Remember this
            HelpText.Text = Page_Resources.Remember_Where;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 5);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            DemoTimer.Begin();
            yield return 0;

            //Then another will appear
            HelpText.Text = Page_Resources.Another_Will_Appear;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Begin();
            yield return 0;
            square.SetValue(Grid.RowProperty, 0);
            square.SetValue(Grid.ColumnProperty, 2);
            PlayingSurface.InvalidateArrange();
            FadeIn.Begin();
            AudioPlayer_2.Position = new TimeSpan(0);
            AudioPlayer_2.Play();
            DemoTimer.Duration = new TimeSpan(0, 0, 4);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            FadeBoxOut.Begin();
            yield return 0;


            //Here, we're going to break it down for you.
            HelpText.Text = Page_Resources.Break_It_Down;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 6);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            yield return 0;


            //If the square now re-appears in the same location...
            HelpText.Text = Page_Resources.If_Square;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 2);
            DemoTimer.Begin();
            yield return 0;
            square.SetValue(Grid.RowProperty, 0);
            square.SetValue(Grid.ColumnProperty, 0);
            PlayingSurface.InvalidateArrange();
            FadeIn.Begin();
            DemoTimer.Begin();
            yield return 0;
            Left_Success.Begin();
            DemoTimer.Begin();
            yield return 0;
            FadeBoxOut.Begin();
            FadeHelpTextOut.Begin();
            yield return 0;


            //If the same letter is said...
            HelpText.Text = Page_Resources.If_Audio;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 3);
            DemoTimer.Begin();
            yield return 0;
            AudioPlayer_1.Position = new TimeSpan(0);
            AudioPlayer_1.Play();
            DemoTimer.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 2);
            DemoTimer.Begin();
            Right_Success.Begin();
            yield return 0;
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            yield return 0;



            //If both happen...
            HelpText.Text = Page_Resources.If_Both_Happen;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 4);
            DemoTimer.Begin();
            yield return 0;
            square.SetValue(Grid.RowProperty, 0);
            square.SetValue(Grid.ColumnProperty, 0);
            PlayingSurface.InvalidateArrange();
            FadeIn.Begin();
            AudioPlayer_1.Position = new TimeSpan(0);
            AudioPlayer_1.Play();
            DemoTimer.Duration = new TimeSpan(0, 0, 2);
            DemoTimer.Begin();
            yield return 0;
            Left_Success.Begin();
            Right_Success.Begin();
            DemoTimer.Begin();
            yield return 0;
            FadeBoxOut.Begin();
            FadeHelpTextOut.Begin();
            yield return 0;



            //Continue on to the next round...
            HelpText.Text = Page_Resources.Continue_Round;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 5);
            DemoTimer.Begin();
            yield return 0;
            PlayingSurface.ShowGridLines = false;
            FadeHelpTextOut.Begin();
            yield return 0;


            //As you get better, it'll get harder
            HelpText.Text = Page_Resources.As_Get_Better;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 5);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpTextOut.Begin();
            yield return 0;


            //Continue for 20 sessions
            HelpText.Text = Page_Resources.Continue_Sessions;
            gt = SessionText.TransformToVisual(Application.Current.RootVisual as UIElement);
            offset = gt.Transform(new Point(0, 0));
            ArrowPopup.HorizontalOffset = offset.X + 10;
            ArrowPopup.VerticalOffset = offset.Y + 10;
            ArrowPopup.IsOpen = true;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 6);
            DemoTimer.Begin();
            yield return 0;
            ArrowPopup.IsOpen = false;
            FadeHelpTextOut.Begin();
            yield return 0;


            //Good luck!
            HelpText.Text = Page_Resources.Good_Luck;
            FadeHelpTextIn.Begin();
            yield return 0;
            DemoTimer.Duration = new TimeSpan(0, 0, 3);
            DemoTimer.Begin();
            yield return 0;
            FadeHelpBoxOut.Begin();
            yield return 0;

                






        }


        /// <summary>
        /// Called by timers when a demo step is finished.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void demoStepEnded(object sender, EventArgs e)
        {
            DemoTimer.Seek(new TimeSpan(0, 0, 0));
            nextDemoStep();
        }

        //private Page_Resources
        //private Page_XAML _Resources = new Page_XAML();
        //private ResourceManager _Rm = new ResourceManager("NBack.Page", Assembly.GetExecutingAssembly());
	}
}