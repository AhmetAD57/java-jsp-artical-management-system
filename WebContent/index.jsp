<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Makale Sistemi Giriş Sayfası</title>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    
    <link rel="stylesheet" type="text/css" href="css/customstyle.css">


</head>
<body>
 <div class="container">
        
<!--         Yazar giriş -->
        
        <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h3>Yazar Giriş</h3>
                </div>
                <form action="VeriTabaniSorgu.jsp">
                <input type="hidden" name="islem" value="Giris">
                <input type="hidden" name="alan" value="yazarlar">
                <div class="card-body">
                   
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Yazar adı" name="y_ka" required="required">
                         </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" class="form-control" placeholder="Şifre" name="y_s" required="required" minlength="8">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Giriş" class="btn float-right login_btn">
                        </div>
                    </form>
                </div>
                <p>
             	<%if(session.getAttribute("y_login")!=null){
	             	if(session.getAttribute("y_login")=="false"){%>
		                <div class="alert alert-danger alert-dismissible fade show" role="alert">
		                    Yazar adı veya şifre yanlış
		                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
	 				<%}
 					session.setAttribute("y_login", null);
             	}%>
                <div class="card-footer">
                     <div class="d-flex justify-content-center links">
                        <a href="SifremiUnuttum.jsp?alan=yazarlar">Şifremi unuttum</a>
                    </div>
                    <div class="d-flex justify-content-center links">
                        Yazar değil misiniz?<a href="YazarKayit.jsp">Kayıt ol</a>
                    </div>
                 </div>
            </div>
            
            
           <!--         Editör giriş --> 
            
            <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h3>Editör Giriş</h3>
                </div>
                <form action="VeriTabaniSorgu.jsp">
                <input type="hidden" name="islem" value="Giris">
                <input type="hidden" name="alan" value="editorler">
                <div class="card-body">
                   
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Editör adı" name="e_ka" required="required">
                         </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" class="form-control" placeholder="Şifre" name="e_s" required="required" minlength="8">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Giriş" class="btn float-right login_btn">
                        </div>
                    </form>
                </div>
                <p>
             	<%if(session.getAttribute("e_login")!=null){
	             	if(session.getAttribute("e_login")=="false"){%>
		                <div class="alert alert-danger alert-dismissible fade show" role="alert">
		                    Editör adı veya şifre yanlış
		                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
	 				<%}
 					session.setAttribute("e_login", null);
             	}%>
                <div class="card-footer">
                     <div class="d-flex justify-content-center links">
                        <a href="SifremiUnuttum.jsp">Şifremi unuttum</a>
                    </div>
                   
                 </div>
            </div>
            
            
            
          <!--         Hakem giriş -->  
            <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h3>Hakem Giriş</h3>
                </div>
                <form action="VeriTabaniSorgu.jsp">
                <input type="hidden" name="islem" value="Giris">
                <input type="hidden" name="alan" value="hakemler">
                <div class="card-body">
                   
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Hakem adı" name="h_ka" required="required">
                         </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" class="form-control" placeholder="Şifre" name="h_s" required="required" minlength="8">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Giriş" class="btn float-right login_btn">
                        </div>
                    </form>
                </div>
                <p>
             	<%if(session.getAttribute("h_login")!=null){
             		if(session.getAttribute("h_login")=="false"){%>
		                <div class="alert alert-danger alert-dismissible fade show" role="alert">
		                    Hakem adı veya şifre yanlış
		                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
 					<%}
 					session.setAttribute("h_login", null);
             	}%>
                <div class="card-footer">
                     <div class="d-flex justify-content-center links">
                        <a href="SifremiUnuttum.jsp?alan=hakemler">Şifremi unuttum</a>
                    </div>
                    <div class="d-flex justify-content-center links">
                        Hakem değil misiniz?<a href="HakemKayit.jsp">Kayıt ol</a>
                    </div>
                 </div>
            </div>
            
            
            
</div>
</body>
</html>