using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.SqlServer.Dts.Runtime;


public partial class NuggetTaskEditor : Form
{
    TaskHost _th;

    public NuggetTaskEditor(TaskHost th)
    {
        InitializeComponent();

        this._th = th;
        this.numInterval.Value = (int)this._th.Properties["Interval"].GetValue(this._th);
    }

    private void btnDone_Click(object sender, EventArgs e)
    {            
        this._th.Properties["Interval"].SetValue(this._th, this.numInterval.Value);
    }

}