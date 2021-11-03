<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
	<title>Makale Sistemi</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="assets/materialize/css/materialize.min.css" media="screen,projection" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="assets/js/Lightweight-Chart/cssCharts.css">
    
    <style type="text/css">
    	body {
	  		background-color: #e0e8f5;
		}
    </style>

</head>
<body>
<%if(session.getAttribute("AYId")==null && session.getAttribute("AEId")==null && session.getAttribute("AHId")==null){
    response.sendRedirect("index.jsp"); 
}%>
<div class="container">

	<div class="header">
		<h1 class="page-header">
 			Şifre Güncelle
   		</h1>
	</div>
        
        			
       	
       	<div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <%
                	String id=request.getParameter("id");
              		String alan=request.getParameter("alan");
              	%>
                <div class="card">
                 <div class="card-content">
                <form action="VeriTabaniSorgu.jsp">
				   		 <input type="hidden" name="islem" value="SifreGuncelle">
						 <input type="hidden" name="id" value="<%=id%>">
						 <input type="hidden" name="alan" value="<%=alan%>">
						  
						  <div class="form-group">
						    <label for="exampleInputEmail1">Şuanki şifre</label>
						    <input type="password" class="form-control" name="asifre" aria-describedby="emailHelp" placeholder="Aktfi şifre" required="required" minlength="8">
						  <div class="form-group">
						    <label for="exampleInputPassword1">Yeni şifre</label>
						    <input type="password" class="form-control" name="ysifre" placeholder="Yeni şifre" required="required" minlength="8">
						  </div>
						  <div class="form-group">
						    <label for="exampleInputPassword1">Yeni şifre tekrar</label>
						    <input type="password" class="form-control" name="ysifret" placeholder="Yeni şifre tekrar" required="required" minlength="8">
						  </div>
						  <button type="submit" class="btn btn-warning">Güncelle</button>
					</form>
                      
                      <%if(session.getAttribute("SifreDH")!=null){
				          	if(session.getAttribute("SifreDH")=="false"){%>
				            	<div class="alert alert-danger m-y-2" role="alert">
				                	Alanlar hatalı yada uyuşmuyor
				                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                    </button>
				                </div>
				 				<%}
							session.setAttribute("SifreDH", null);
					        }%>
               
                </div>
                
        
                <!--End Advanced Tables -->
            </div>
        </div>
      
   	</div>
   
    </div>
   
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>

    <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>

    <script src="assets/materialize/js/materialize.min.js"></script>

    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
    <!-- Morris Chart Js -->
    <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="assets/js/morris/morris.js"></script>


    <script src="assets/js/easypiechart.js"></script>
    <script src="assets/js/easypiechart-data.js"></script>

    <script src="assets/js/Lightweight-Chart/jquery.chart.js"></script>

    <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
</body>
</html>
 	
