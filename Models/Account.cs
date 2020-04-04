using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcPlantilla.Models
{
    public class Account
    {
        public string nombreUsuario { get; set; }
        public string contrasena { get; set; }
        public string rol { get; set; }
    }
}