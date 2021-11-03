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
       	<%String durum=String.valueOf(request.getParameter("durum"));%>
       	<div id="page-wrapper">
        	<div class="header">
            	<h1 class="page-header">
                	<%if(durum.equals("Teklif")){ %>
                		<%=durum %> Edilen Makaleler
                	<%}
                	if(durum.equals("Evet")){%>
                		Rapor Bekleyen Makaleler
                	<%}
                	if(durum.equals("Raporlu")){%>
                		<%=durum %> Makaleler
                	<%}%>
                </h1>
          	</div>
                 <jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
                <%
                session.setAttribute("makale_adi", null);
                session.setAttribute("makale_rapor", "yok");
                
                int[] Bilgiler=Db.HDurumBilgileri(String.valueOf(session.getAttribute("AHId")));
                %>
              
                <div id="page-inner">
        				<div class="dashboard-cards">
                            <div class="row">
                                <a href="HAnasayfa.jsp?durum=Teklif">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image blue">
                                                <i class="material-icons dp48">assignment_ind</i>
                                            </div>
                                            <div class="card-stacked blue">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[0] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>TEKLİFLER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </a>
        
                                <a href="HAnasayfa.jsp?durum=Evet">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
        
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image orange">
                                                <i class="material-icons dp48">list</i>
                                            </div>
                                            <div class="card-stacked orange">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[1] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>RAPOR BEKLEYENLER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                         		</a>
                         		
                         		<a href="HAnasayfa.jsp?durum=Raporlu">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
        
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image green">
                                                <i class="material-icons dp48">list</i>
                                            </div>
                                            <div class="card-stacked green">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[2] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>RAPORLULAR</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                         		</a>
        					</div>
                        </div>
       	
       	<div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="card">
                    <div class="card-action">
                    	<form class="form-inline" action="HAnasayfa.jsp">
							<input type="hidden" name="durum" value="<%=durum%>">
							<div class="form-group mx-sm-3 mb-2">
							    <input type="text" class="form-control" name="kelime" placeholder="Başlığa Göre Ara"> <!-- Hepsinde aynı -->
							  </div>
							  <button type="submit" class="btn btn-primary mb-2">Ara</button>
						</form>

                    </div>
                    <div class="card-content">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
	                                   <%if(durum.equals("Teklif")){ %>
	                                    	<th>Teklif Id</th>
	                                    	<th>Makale Id</th>
	                                        <th>Başlık</th>
	                                        <th>Yazar</th>
	                                        <th>Durum</th>
	                                       	<th>Makale</th>
	                                        <th>Onay</th>
	                                    <%}
	                                   	if(durum.equals("Evet") || durum.equals("Raporlu")){%>
	                                   		<th>Teklif Id</th>
	                                    	<th>Makale Id</th>
	                                        <th>Başlık</th>
	                                        <th>Yazar</th>
	                                        <th>Durum</th>
	                                       	<th>Makale</th>
	                                        <th>Rapor</th>
	                                        <th>Son Teslim Tarihi</th>
	                                    <%}%>
	                                    
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    ResultSet Rs=Db.HMakaleGetir(durum, String.valueOf(session.getAttribute("AHId")), String.valueOf(request.getParameter("kelime")));
                                    
                                    while(Rs.next()){
                                    	if(durum.equals("Teklif")){%>
                                    		<tr>
                                    			<td><%=Rs.getString("tid")%></td>
		                                    	<td><%=Rs.getString("mid")%></td>
		                                        <td><%=Rs.getString("baslik")%></td>
		                                        <td><%=Rs.getString("yad")%></td>
		                                        <td><%=Rs.getString("durum")%></td>
		                                        <td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
		                                        <td>
		                                        	<a class="btn btn-success btn-sm" href="HakemTercih.jsp?id=<%=Rs.getString("mid")%>&tercih=Evet" role="button">Kablu Et</a>
		                                        	<a class="btn btn-danger btn-sm" href="HakemTercih.jsp?id=<%=Rs.getString("mid")%>&tercih=Hayır" role="button">Red Et</a>
		                                        </td>
	                                 		</tr>
	                                    <%}
	                                    if(durum.equals("Evet")){%>
	                                    	<tr>
                                    			<td><%=Rs.getString("tid")%></td>
		                                    	<td><%=Rs.getString("mid")%></td>
		                                        <td><%=Rs.getString("baslik")%></td>
		                                        <td><%=Rs.getString("yad")%></td>
		                                        <%-- <td><%=Rs.getString("durum")%></td> --%>
												<td>Kabul edildi</td>
		                                        <td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
		                                        <td>
		                                        	<a class="btn btn-success btn-sm" href="RaporYukle.jsp?id=<%=Rs.getString("mid")%>&tid=<%=Rs.getString("tid")%>" role="button">Rapor Yükle</a>
		                                        </td>
		                                        <td><%=Rs.getString("kabultarihi")%></td>
	                                 		</tr>
		                                <%}	                                    
	                                    if(durum.equals("Raporlu")){%>
	                                    	<tr>
                                    			<td><%=Rs.getString("tid")%></td>
		                                    	<td><%=Rs.getString("mid")%></td>
		                                        <td><%=Rs.getString("baslik")%></td>
		                                        <td><%=Rs.getString("yad")%></td>
		                                        <td><%=Rs.getString("durum")%></td>
		                                        <td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
		                                        <td><a href="articals/<%=Rs.getString("rad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
		                                        <td><%=Rs.getString("kabultarihi")%></td>
	                                 		</tr>
		                          		<%}
	                                    
                                   	}%>
                                </tbody>
                            </table>
                        </div>

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