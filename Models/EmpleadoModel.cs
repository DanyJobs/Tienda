using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcPlantilla.Models
{
    public class EmpleadoModel
    {

        public int idEmpleado { get; set; }
        public string nombre { get; set; }
        public string app { get; set; }  
        public string apm { get; set;}
        public string email { get; set; }
        public string calle  { get; set; }
        public string numExt  { get; set; }
        public string colonia { get; set; }
        public string cp  { get; set; }
        public string celular { get; set; }
        public DateTime fecNac { get; set; }
        public int idCiudad  { get; set; }
        public int idJefe  { get; set; }
        public int idSucursal  { get; set; }
        public string estatus { get; set; }
        public string nombreUsuario  { get; set; }
        public string contrasena  { get; set; }
        public string rango  { get; set; }

    }
}