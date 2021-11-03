<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Kayıt Ol</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<link rel="stylesheet" type="text/css" href="css/customstyle.css">





</head>
<body>

<div class="container">
   
    <div class="d-flex justify-content-center h-100">
        <div class="card" style="height:450px;">
            <div class="card-header">
                <h3>Kayıt Ol</h3>
            </div>
            <div class="card-body">
               <form action="VeriTabaniSorgu.jsp">
                    	 <input type="hidden" name="islem" value="Kayit">
                    	 <input type="hidden" name="kalan" value="YazarKayit.jsp">
                    	<div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                            </div>
                            <input type="text" class="form-control" placeholder="Kullanıcı adı" required="required" name="y_ad">
                        </div>
                        
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                            </div>
                            <input type="text" class="form-control" placeholder="Şifre" required="required" name="y_sifre" minlength="8">
                        </div>
                        
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                            </div>
                            <input type="email" class="form-control" placeholder="Email adresi" required="required" name="y_email">
                        </div>
                    
                       <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block"> Kayıt Ol</button>
                        </div>
                     </form>  
            </div>
           
          		
             	<%if(session.getAttribute("KHata")!=null){
	              	if(session.getAttribute("KHata")=="false"){%>
		                <div class="alert alert-danger alert-dismissible fade show" role="alert">
		                        Lütfen farklı bir kullanıcı adı veye şifre giriniz
		                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		                            <span aria-hidden="true">&times;</span>
		                        </button>
		                </div>
            		<%}
	              	session.setAttribute("KHata", null);
             	}%> 

           <div class="card-footer">
                <div class="d-flex justify-content-center links">
                    Bir hesabınız varmı?<a href="index.jsp">Giriş Yap</a>
                </div>
            </div>
        </div>
    </div>







</body>
</html>