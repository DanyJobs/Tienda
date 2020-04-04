<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <meta name="description" content="ASP.NET MVC 2 CRUD Video"></meta>
  <meta name="keywords" content="ASP.NET, MVC, Facpya"></meta>
  <meta name="author" content="Juan Daniel Mata Lopez"></meta>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
    <title>Login</title>
</head>
<body>
<form action="/Home/Acceso" method="post">
<center>
         <label for="nombreUsuario">Usuario</label>
        <input type="text" name="nombreUsuario" />
        <label for="contrasena">Contraseña</label>
        <input type="text" name="contrasena" /> 
        <input type="submit" value="Registrar" />
 </center>    
    </form>
    
</body>
</html>
