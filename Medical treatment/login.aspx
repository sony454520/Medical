<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Medical_treatment.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>--%>
    <script src="Scripts/popper.min.js"></script>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>--%>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="Content/signin.css" />
</head>
<body class="text-center">
    <form class="form-signin" runat="server">
      <%--<img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">--%>
      <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input type="text" id="inputEmail" class="form-control" placeholder="Acoount" /><%--required="required" autofocus="autofocus"--%>
      <label for="inputPassword" class="sr-only">Password</label>
      <input type="password" id="inputPassword" class="form-control" placeholder="Password" /><%--required="required"--%>
      <div class="checkbox mb-3">
        <label>
          <input type="checkbox" value="remember-me"/> Remember me
        </label>
      </div>
      <%--<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>--%>
        <asp:Button CssClass="btn btn-lg btn-primary btn-block" ID="Button1" runat="server" Text="Sign in" OnClick="Button1_Click" />
      <%--<p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p>--%>
    </form>
</body>
</html>
