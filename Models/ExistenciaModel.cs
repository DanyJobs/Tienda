using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcPlantilla.Models
{
    public class ExistenciaModel
    {
         public int idProducto { get; set; }
         public int idSucursal { get; set; }
         public int cantidad { get; set; }
         public string estatus { get; set; }
    }
}