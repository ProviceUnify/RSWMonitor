﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class Component
    {
        public int Id { get; set; }
        public int ComponentTypesId { get; set; }
        public int ConfigurationId { get; set; }
        public string ComponentName { get; set; }
        public string ComponentQuery { get; set; }
        public string ComponentRoletags { get; set; }
        public bool ComponentHasControls { get; set; }
        public string ComponentFullPathToExe { get; set; }

        public virtual ComponentType ComponentTypes { get; set; }
        public virtual Configuration Configuration { get; set; }
    }
}