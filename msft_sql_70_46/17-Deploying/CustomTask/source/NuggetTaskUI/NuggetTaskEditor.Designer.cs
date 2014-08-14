
partial class NuggetTaskEditor
{
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
        if (disposing && (components != null))
        {
            components.Dispose();
        }
        base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
            this.btnDone = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.numInterval = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.numInterval)).BeginInit();
            this.SuspendLayout();
            // 
            // btnDone
            // 
            this.btnDone.Location = new System.Drawing.Point(4, 47);
            this.btnDone.Name = "btnDone";
            this.btnDone.Size = new System.Drawing.Size(193, 26);
            this.btnDone.TabIndex = 0;
            this.btnDone.Text = "OK";
            this.btnDone.UseVisualStyleBackColor = true;
            this.btnDone.Click += new System.EventHandler(this.btnDone_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(8, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(77, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Pause interval:";
            // 
            // numInterval
            // 
            this.numInterval.Location = new System.Drawing.Point(88, 12);
            this.numInterval.Name = "numInterval";
            this.numInterval.Size = new System.Drawing.Size(59, 20);
            this.numInterval.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(148, 15);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "minutes";
            // 
            // NuggetTaskEditor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(204, 81);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.numInterval);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnDone);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "NuggetTaskEditor";
            this.Text = "Configure Nugget Pause Task";
            ((System.ComponentModel.ISupportInitialize)(this.numInterval)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.Button btnDone;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.NumericUpDown numInterval;
    private System.Windows.Forms.Label label2;
}
