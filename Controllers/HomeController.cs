using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data;
using MVCPlantilla.Utilerias;

namespace MvcPlantilla.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Acceso(string nombreUsuario, string contrasena)
        {
            //List<SqlParameter> parametros = new List<SqlParameter>();
            //DataTable datos = new DataTable();
            //parametros.Add(new SqlParameter("@nombreUsuario", nombreUsuario));
            //parametros.Add(new SqlParameter("@contrasena", contrasena));
            //datos = BaseHelper.ejecutarConsulta("spAcceso", CommandType.StoredProcedure, parametros);
            //if (datos.Rows.Count == 1)
            //{
            //    Response.Write("<script>alert('Correcto adelante')</script>");
            //    return RedirectToAction("Index", "Empleado");
            //}
            //else {
            //    Response.Write("<script>alert('Contraseña o usuario incorrectos')</script>");
            //    return RedirectToAction("Index", "Home");               
            //}
        }

    }
}
