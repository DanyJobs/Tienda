using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcPlantilla.Models
{
    public class CiudadModel
    {
        public int idCiudad { get; set; }
        public string descripcion { get; set; }
        public int idEstado { get; set; }
        public string estatus { get; set; }       

    }
}