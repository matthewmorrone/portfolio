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
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace NBack
{
    public partial class NDisplayGrid : UserControl
    {
        public NDisplayGrid()
        {
            InitializeComponent();
        }

        
        /// <summary>
        /// displays appropriate N to user
        /// </summary>
        /// <param name="n"></param>
        public void DisplayN(int n)
        {
            Border7.Visibility = Visibility.Collapsed;
            N7TextBlock.Visibility = Visibility.Collapsed;
            Border6.Visibility = Visibility.Collapsed;
            N6TextBlock.Visibility = Visibility.Collapsed;
            Border5.Visibility = Visibility.Collapsed;
            N5TextBlock.Visibility = Visibility.Collapsed;
            Border4.Visibility = Visibility.Collapsed;
            N4TextBlock.Visibility = Visibility.Collapsed;
            Border3.Visibility = Visibility.Collapsed;
            N3TextBlock.Visibility = Visibility.Collapsed;
            Border2.Visibility = Visibility.Collapsed;
            N2TextBlock.Visibility = Visibility.Collapsed;
            Border1.Visibility = Visibility.Collapsed;
            N1TextBlock.Visibility = Visibility.Collapsed;
            BorderHigh.Visibility = Visibility.Collapsed;
            HighNText.Visibility = Visibility.Collapsed;

            if (n > 7)
            {
                BorderHigh.Visibility = Visibility.Visible;
                HighNText.Visibility = Visibility.Visible;
                HighNText.Text = n.ToString();
            }

            else 
            {
                if (n > 0)
                    Border1.Visibility = Visibility.Visible;
                    N1TextBlock.Visibility = Visibility.Visible;

                if (n > 1)
                    Border2.Visibility = Visibility.Visible;
                    N2TextBlock.Visibility = Visibility.Visible;
                
                if (n > 2)
                    Border3.Visibility = Visibility.Visible;                
                    N3TextBlock.Visibility = Visibility.Visible;
                
                if (n > 3)
                    Border4.Visibility = Visibility.Visible;
                    N4TextBlock.Visibility = Visibility.Visible;
                
                if (n > 4)
                    Border5.Visibility = Visibility.Visible;
                    N5TextBlock.Visibility = Visibility.Visible;
                
                if (n > 5)
                    Border6.Visibility = Visibility.Visible;
                    N6TextBlock.Visibility = Visibility.Visible;
                
                if (n > 6)
                    Border7.Visibility = Visibility.Visible;
                    N7TextBlock.Visibility = Visibility.Visible;









            }

        }

    }
}
