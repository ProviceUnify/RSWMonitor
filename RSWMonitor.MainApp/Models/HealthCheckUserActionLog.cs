﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class HealthCheckUserActionLog
    {
        public int UserActionEntryId { get; set; }
        public string UserId { get; set; }
        public string ActionDetails { get; set; }
        public int UserActionId { get; set; }
        public DateTime? Datetime { get; set; }

        public virtual AspNetUser User { get; set; }
        public virtual UserAction UserAction { get; set; }
    }
}