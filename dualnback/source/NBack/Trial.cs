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

namespace NBack
{
    /// <summary>
    /// Represents a single presentation of visual/audio stimulus to
    ///  the user.
    /// </summary>
    public class Trial
    {
        public SquarePosition Position { get; set; }
        public Consonant Letter { get; set; }
        /// <summary>
        /// Is this trial the second in a "target" (a matching pair).  And if so, what kind?
        /// </summary>
        public TargetKind SecondTrialInTarget { get; set; }

        //private SquarePosition _position;
        //private Consonant _letter;

        public Trial(SquarePosition position, Consonant cons)
        {
            Position = position;
            Letter = cons;
            SecondTrialInTarget = TargetKind.None;

        }

    }

    /// <summary>
    /// Possible positions of the square as it's displayed to the user.
    /// </summary>
    public enum SquarePosition
    {
        TopLeft = 0,
        TopMiddle,
        TopRight,
        MiddleRight,
        BottomRight,
        BottomMiddle,
        BottomLeft,
        MiddleLeft
    }

    /// <summary>
    /// Possible consonants to be played to the user.
    /// </summary>
    public enum Consonant
    {
        Letter1 = 0,
        Letter2,
        Letter3,
        Letter4,
        Letter5,
        Letter6,
        Letter7,
        Letter8
    }

    public enum TargetKind
    {
        Audio,
        Visual,
        Both,
        None, //This trial doesn't match
        TooEarly //This trial is too early in the list, and it doesn't have an earlier pair.
    }
}
