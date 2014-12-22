#pragma checksum "C:\Documents and Settings\user\Desktop\Nback_Open\NBack\Page.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "B754118D3D8764E8629777099BD3E56E"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.1433
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using NBack;
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Hosting;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Resources;
using System.Windows.Shapes;
using System.Windows.Threading;


namespace NBack {
    
    
    public partial class Page : System.Windows.Controls.UserControl {
        
        internal System.Windows.Media.Animation.Storyboard FadeBoxOut;
        
        internal System.Windows.Media.Animation.SplineDoubleKeyFrame FadeOut;
        
        internal System.Windows.Media.Animation.Storyboard FadeIn;
        
        internal System.Windows.Media.Animation.Storyboard TrialTimer;
        
        internal System.Windows.Media.Animation.Storyboard Timer_1;
        
        internal System.Windows.Media.Animation.Storyboard Feedback;
        
        internal System.Windows.Media.Animation.Storyboard FadeInHelpBox;
        
        internal System.Windows.Media.Animation.Storyboard FadeHelpBoxOut;
        
        internal System.Windows.Media.Animation.Storyboard DemoTimer;
        
        internal System.Windows.Media.Animation.Storyboard FadeHelpTextOut;
        
        internal System.Windows.Media.Animation.Storyboard FadeHelpTextIn;
        
        internal System.Windows.Media.Animation.Storyboard Left_Success;
        
        internal System.Windows.Media.Animation.Storyboard Left_Failure;
        
        internal System.Windows.Media.Animation.Storyboard Right_Success;
        
        internal System.Windows.Media.Animation.Storyboard Right_Failure;
        
        internal System.Windows.Media.Animation.Storyboard InitialWait;
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal NBack.NDisplayGrid ShowN;
        
        internal System.Windows.Controls.Button StartButton;
        
        internal System.Windows.Shapes.Ellipse SuccessCircle;
        
        internal System.Windows.Controls.Primitives.Popup EndBlockPopup;
        
        internal System.Windows.Controls.TextBlock NumberBack;
        
        internal System.Windows.Controls.TextBlock AudioTargetsText;
        
        internal System.Windows.Controls.TextBlock VisualTargetsText;
        
        internal System.Windows.Controls.Button ContinueButton;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_1;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_2;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_3;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_4;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_5;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_6;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_7;
        
        internal System.Windows.Controls.MediaElement AudioPlayer_8;
        
        internal System.Windows.Controls.Border Progress;
        
        internal NBack.ProgressBar ProgBar;
        
        internal System.Windows.Controls.Primitives.Popup PausePopup;
        
        internal System.Windows.Controls.Grid Scores;
        
        internal System.Windows.Controls.TextBlock SessionText;
        
        internal System.Windows.Controls.TextBlock ScoreText;
        
        internal System.Windows.Controls.Border PlayingBorder;
        
        internal System.Windows.Controls.Grid PlayingSurface;
        
        internal System.Windows.Controls.Border square;
        
        internal System.Windows.Controls.Border L_Border;
        
        internal System.Windows.Controls.TextBlock AText;
        
        internal System.Windows.Controls.Border HelpTextControl;
        
        internal System.Windows.Controls.TextBlock HelpText;
        
        internal System.Windows.Controls.Primitives.Popup ArrowPopup;
        
        internal System.Windows.Controls.Border R_Border;
        
        internal System.Windows.Controls.TextBlock LText;
        
        internal System.Windows.Controls.TextBlock PopupTarget;
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Windows.Application.LoadComponent(this, new System.Uri("/NBack;component/Page.xaml", System.UriKind.Relative));
            this.FadeBoxOut = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeBoxOut")));
            this.FadeOut = ((System.Windows.Media.Animation.SplineDoubleKeyFrame)(this.FindName("FadeOut")));
            this.FadeIn = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeIn")));
            this.TrialTimer = ((System.Windows.Media.Animation.Storyboard)(this.FindName("TrialTimer")));
            this.Timer_1 = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Timer_1")));
            this.Feedback = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Feedback")));
            this.FadeInHelpBox = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeInHelpBox")));
            this.FadeHelpBoxOut = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeHelpBoxOut")));
            this.DemoTimer = ((System.Windows.Media.Animation.Storyboard)(this.FindName("DemoTimer")));
            this.FadeHelpTextOut = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeHelpTextOut")));
            this.FadeHelpTextIn = ((System.Windows.Media.Animation.Storyboard)(this.FindName("FadeHelpTextIn")));
            this.Left_Success = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Left_Success")));
            this.Left_Failure = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Left_Failure")));
            this.Right_Success = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Right_Success")));
            this.Right_Failure = ((System.Windows.Media.Animation.Storyboard)(this.FindName("Right_Failure")));
            this.InitialWait = ((System.Windows.Media.Animation.Storyboard)(this.FindName("InitialWait")));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.ShowN = ((NBack.NDisplayGrid)(this.FindName("ShowN")));
            this.StartButton = ((System.Windows.Controls.Button)(this.FindName("StartButton")));
            this.SuccessCircle = ((System.Windows.Shapes.Ellipse)(this.FindName("SuccessCircle")));
            this.EndBlockPopup = ((System.Windows.Controls.Primitives.Popup)(this.FindName("EndBlockPopup")));
            this.NumberBack = ((System.Windows.Controls.TextBlock)(this.FindName("NumberBack")));
            this.AudioTargetsText = ((System.Windows.Controls.TextBlock)(this.FindName("AudioTargetsText")));
            this.VisualTargetsText = ((System.Windows.Controls.TextBlock)(this.FindName("VisualTargetsText")));
            this.ContinueButton = ((System.Windows.Controls.Button)(this.FindName("ContinueButton")));
            this.AudioPlayer_1 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_1")));
            this.AudioPlayer_2 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_2")));
            this.AudioPlayer_3 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_3")));
            this.AudioPlayer_4 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_4")));
            this.AudioPlayer_5 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_5")));
            this.AudioPlayer_6 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_6")));
            this.AudioPlayer_7 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_7")));
            this.AudioPlayer_8 = ((System.Windows.Controls.MediaElement)(this.FindName("AudioPlayer_8")));
            this.Progress = ((System.Windows.Controls.Border)(this.FindName("Progress")));
            this.ProgBar = ((NBack.ProgressBar)(this.FindName("ProgBar")));
            this.PausePopup = ((System.Windows.Controls.Primitives.Popup)(this.FindName("PausePopup")));
            this.Scores = ((System.Windows.Controls.Grid)(this.FindName("Scores")));
            this.SessionText = ((System.Windows.Controls.TextBlock)(this.FindName("SessionText")));
            this.ScoreText = ((System.Windows.Controls.TextBlock)(this.FindName("ScoreText")));
            this.PlayingBorder = ((System.Windows.Controls.Border)(this.FindName("PlayingBorder")));
            this.PlayingSurface = ((System.Windows.Controls.Grid)(this.FindName("PlayingSurface")));
            this.square = ((System.Windows.Controls.Border)(this.FindName("square")));
            this.L_Border = ((System.Windows.Controls.Border)(this.FindName("L_Border")));
            this.AText = ((System.Windows.Controls.TextBlock)(this.FindName("AText")));
            this.HelpTextControl = ((System.Windows.Controls.Border)(this.FindName("HelpTextControl")));
            this.HelpText = ((System.Windows.Controls.TextBlock)(this.FindName("HelpText")));
            this.ArrowPopup = ((System.Windows.Controls.Primitives.Popup)(this.FindName("ArrowPopup")));
            this.R_Border = ((System.Windows.Controls.Border)(this.FindName("R_Border")));
            this.LText = ((System.Windows.Controls.TextBlock)(this.FindName("LText")));
            this.PopupTarget = ((System.Windows.Controls.TextBlock)(this.FindName("PopupTarget")));
        }
    }
}