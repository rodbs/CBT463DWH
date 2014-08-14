using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using Microsoft.SqlServer.Dts.Runtime;


namespace SSIS.CustomTasks
{
    [DtsTask(DisplayName = "Nugget Pause",
                Description = "Custom SSIS Task to pause control flow.",
                TaskType = "General",
                IconResource = "NuggetTask.pause.ico",
                UITypeName = "SSIS.CustomTasks.NuggetTaskUI,NuggetTaskUI,Version=1.0.0.0,Culture=Neutral,PublicKeyToken=d9081b0cb22ebbde")]
    public class NuggetTask : Task
    {
        int _interval;

        [Category("Misc")]
        [Description("Interval in minutes to pause for.")]
        public int Interval
        {
            get { return this._interval; }
            set { this._interval = value; }
        }

        public override void InitializeTask(Connections connections, VariableDispenser variableDispenser, IDTSInfoEvents events, IDTSLogging log, EventInfos eventInfos, LogEntryInfos logEntryInfos, ObjectReferenceTracker refTracker)
        {
            base.InitializeTask(connections, variableDispenser, events, log, eventInfos, logEntryInfos, refTracker);

            this._interval = 1;
        }

        public override DTSExecResult Validate(Connections connections, VariableDispenser variableDispenser, IDTSComponentEvents componentEvents, IDTSLogging log)
        {
            if (this._interval <= 0)
            {
                componentEvents.FireError(0, "", "Pause length must be greater than 0.", "", 0);
                return DTSExecResult.Failure;
            }

            return DTSExecResult.Success;
        }

        public override DTSExecResult Execute(Connections connections, VariableDispenser variableDispenser, IDTSComponentEvents componentEvents, IDTSLogging log, object transaction)
        {

            System.Threading.Thread.Sleep(this._interval * 60000);

            return DTSExecResult.Success;
        }

    }
}