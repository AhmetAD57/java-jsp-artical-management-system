<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
    
    <title>Hakem Panel</title>
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


</head>
<body>
<%if(session.getAttribute("AHId")==null){
    response.sendRedirect("index.jsp"); 
	}
%>

	<div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                 <a class="navbar-brand waves-effect waves-dark" href="HAnasayfa.jsp?durum=Teklif"><strong>Hakem Panel</strong></a>

                <div id="sideNav" href=""><i class="material-icons dp48">toc</i></div>
            </div>

           <ul class="nav navbar-top-links navbar-right">
                <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b>Hoş geldiniz, <%=session.getAttribute("AHAd")%></b> <i class="material-icons right">arrow_drop_down</i></a></li>
            </ul>
        </nav>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
           <li>
                <a href="SifreDegistir.jsp?id=<%=String.valueOf(session.getAttribute("AHId"))%>&alan=hakemler"><i class="fa fa-cogs fa-fw"></i> Şifre Güncelle</a>
           </li>
           <li>
                <a href="VeriTabaniSorgu.jsp?islem=cikis&alan=hakemler"><i class="fa fa-sign-out fa-fw"></i> Çıkış yap</a>
            </li>
        </ul>
       
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
					<li>
                        <a href="HAnasayfa.jsp?durum=Teklif" class="waves-effect waves-dark"><i class="fa fa-user"></i> Teklifler</a>
                    </li>

                    <li>
                        <a href="HAnasayfa.jsp?durum=Evet" class="waves-effect waves-dark"><i class="fa fa-bars"></i> Rapor Bekleyenler</a>
                    </li>
                    <li>
                        <a href="HAnasayfa.jsp?durum=Raporlu" class="waves-effect waves-dark"><i class="fa fa-check-circle"></i> Raporlular</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  ALANLARIN İÇERİKLERİ BÖLÜMÜ LAYOUT-->
       
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">
            Rapor Yükle
        </h1>
    </div>
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="card">
                   <div class="card-content">
                     	<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
                     	<%
                     		ResultSet Rs; 
                     		String mid=request.getParameter("id"); 
                     		String tid=request.getParameter("tid"); 
							
                     		session.setAttribute("makale_rapor", "id="+mid+"&tid="+tid);
                     		
                  			Rs=Db.MakaleBilgi(mid); 
						%>
                     	
                     	<form enctype="multipart/form-data" action="dosyayukle.jsp" method="post">
							<label for="exampleFormControlFile1" style="display: block;">Rapor(.pdf)</label>
                          	<input type="file" name=file" required="required" style="display: inline-block;">
                            
                            <%if(session.getAttribute("makale_adi")!=null){ %>
								<a href="articals/<%=session.getAttribute("makale_adi")%>" target="_blank" style="text-decoration: none;">
         							<img alt="Qries" src="assets/pdf_image.png" width=70">
      							</a>
							<%}%>
								
							<input type="submit" value="Yükle" class="btn btn-warning">
						</form>
                     	
                     	<form action="VeriTabaniSorgu.jsp">
                           	<input type="hidden" name="islem" value="MakaleRaporEkle">
                           	<input type="hidden" name="mid" value="<%=mid %>">
                           	<input type="hidden" name="tid" value="<%=tid %>">
                           	
                           	<div class="form-group">
                                <label for="exampleInputEmail1">Makale</label>
	                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
	                                <thead>
	                                    <tr>
	                           				<th>Başlık</th>
		                               		<th>Makale</th>
		                               		
	                                	</tr>
	                                </thead>
	                                <tbody>
	                            			<tr>	
			                               	<%while(Rs.next()){%>
			                                	<td><%=Rs.getString("baslik")%></td>
			                                 	<td><a href="articals/<%=Rs.getString("ad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
			                           		<%}%>
			                           		</tr>
	                           		</tbody>
	                            </table>
                            </div>
                            
                            
                            <button type="submit" class="btn btn-success">Onayla</button>
                        </form>
						
						
					
					</div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>

     



        <footer>
            <p>Makale Sistemi</p>
        </footer>
    </div>

</div>






        <!-- /. PAGE WRAPPER  -->
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