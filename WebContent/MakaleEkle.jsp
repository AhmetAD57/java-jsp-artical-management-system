<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
    
    <title>Yazar Paneli</title>
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
	<div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                 <a class="navbar-brand waves-effect waves-dark" href="YAnasayfa.jsp?durum=Beklemede"><strong>Yazar Paneli</strong></a>

                <div id="sideNav" href=""><i class="material-icons dp48">toc</i></div>
            </div>

           <ul class="nav navbar-top-links navbar-right">
                <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b>Hoş geldiniz, <%=session.getAttribute("AYAd")%></b> <i class="material-icons right">arrow_drop_down</i></a></li>
            </ul>
        </nav>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
           <li>
                <a href="SifreDegistir.jsp?id=<%=String.valueOf(session.getAttribute("AYId"))%>&alan=yazarlar"><i class="fa fa-cogs fa-fw"></i> Şifre Güncelle</a>
           </li>
           <li>
                <a href="VeriTabaniSorgu.jsp?islem=cikis&alan=yazarlar"><i class="fa fa-sign-out fa-fw"></i> Çıkış yap</a>
           </li>
        </ul>
       
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
					<li>
                        <a href="YAnasayfa.jsp?durum=Beklemede" class="waves-effect waves-dark"><i class="fa fa-user"></i> Beklemedekiler</a>
                    </li>

                    <li>
                        <a href="YAnasayfa.jsp?durum=Aktif" class="waves-effect waves-dark"><i class="fa fa-bars"></i> Aktfiler</a>
                    </li>
                    <li>
                        <a href="YAnasayfa.jsp?durum=Raporlu" class="waves-effect waves-dark"><i class="fa fa-check-circle"></i>Raporlular</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  ALANLARIN İÇERİKLERİ BÖLÜMÜ LAYOUT-->
       
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">
            Makale Ekle
        </h1>
    </div>
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="card">
                   <div class="card-content">
                     	<% session.setAttribute("makale_guncelle", "yok"); 
                     	session.setAttribute("makale_rapor", "yok");%>
                     	<form enctype="multipart/form-data" action="dosyayukle.jsp" method="post">
							<label for="exampleFormControlFile1" style="display: block;">Makale(.pdf)</label>
                          	<input type="file" name=file" required="required" style="display: inline-block;">
                            
                            <%if(session.getAttribute("makale_adi")!=null){ %>
								<a href="articals/<%=session.getAttribute("makale_adi")%>" target="_blank" style="text-decoration: none;">
         							<img alt="Qries" src="assets/pdf_image.png" width=70">
      							</a>
							<%}%>
								
							<input type="submit" value="Seç" class="btn btn-warning">
						</form>
                     	
                     	<form action="VeriTabaniSorgu.jsp">
                           	<input type="hidden" name="islem" value="MakaleEkleGuncelle"> <!--  Hepsinde aynı -->
							<input type="hidden" name="guncelle" value="yok"> 
							<div class="form-group">
                                <label for="exampleInputEmail1">Başlık</label>
                                <input type="text" class="form-control"  name="m_b" required="required">
                            </div>
                            
                            <div class="form-group">
                                <label for="exampleInputEmail1">Alan</label>
                                <select name="m_a_id" class="form-control custom-select my-1 mr-sm-2">
									<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
									<%ResultSet Rs= Db.AlanGetir();
									while(Rs.next()){ %>
										<option  value=<%=Rs.getString("id")%> ><%=Rs.getString("ad")%></option>
									<%}%>
  								</select>
                            </div>
                            
                            
                            
                            
							<button type="submit" class="btn btn-success">Ekle</button>
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