using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace ChapterEight
{
    public partial class Tutorial8_4 : Form
    {
        public Tutorial8_4()
        {
            InitializeComponent();
        }

        private void getScoresButton_Click(object sender, EventArgs e)
        {
            try
            {
                StreamReader inputFile;
                string line;
                int count = 0;
                int total;
                double average;

                char[] delim = { ',' };

                inputFile = File.OpenText("Grades.csv");

                while (!inputFile.EndOfStream)
                {
                    count++;

                    line = inputFile.ReadLine();

                    string[] tokens = line.Split(delim);

                    total = 0;

                    foreach (string str in tokens)
                    {
                        total += int.Parse(str);
                    }

                    average = (double)total / tokens.Length;

                    averagesListBox.Items.Add("The average for student " + count +
                        " is " + average.ToString("n1")); 
                }
                inputFile.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void exitButton_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
