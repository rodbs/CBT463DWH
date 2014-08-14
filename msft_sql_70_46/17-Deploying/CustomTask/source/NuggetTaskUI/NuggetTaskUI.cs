using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.SqlServer.Dts.Runtime;
using Microsoft.SqlServer.Dts.Runtime.Design;

namespace SSIS.CustomTasks
{
    public class NuggetTaskUI : IDtsTaskUI
    {
        TaskHost _th;

        public System.Windows.Forms.ContainerControl GetView()
        {
            return new NuggetTaskEditor(this._th);
        }

        public void Initialize(TaskHost taskHost, IServiceProvider serviceProvider)
        {
            this._th = taskHost;
        }

        public void Delete(IWin32Window parentWindow) { }

        public void New(IWin32Window parentWindow) { }
    }
}