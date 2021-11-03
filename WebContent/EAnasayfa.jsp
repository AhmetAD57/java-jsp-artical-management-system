<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
    
    <title>Editör Paneli</title>
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
<%if(session.getAttribute("AEId")==null){
    response.sendRedirect("index.jsp"); 
}%>
	<div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand waves-effect waves-dark" href="EAnasayfa.jsp?durum=Beklemede"><strong>Editör Paneli</strong></a>

                <div id="sideNav" href=""><i class="material-icons dp48">toc</i></div>
            </div>

            <ul class="nav navbar-top-links navbar-right">
                <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b>Hoş geldiniz, <%=session.getAttribute("AEAd")%></b> <i class="material-icons right">arrow_drop_down</i></a></li>
            </ul>
        </nav>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
           <li>
                <a href="SifreDegistir.jsp?id=<%=String.valueOf(session.getAttribute("AEId"))%>&alan=editorler"><i class="fa fa-cogs fa-fw"></i> Şifre Güncelle</a>
           </li>
           <li>
                <a href="VeriTabaniSorgu.jsp?islem=cikis&alan=editorler"><i class="fa fa-sign-out fa-fw"></i> Çıkış yap</a>
            </li>
        </ul>
       
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
					<li>
                        <a href="EAnasayfa.jsp?durum=Beklemede" class="waves-effect waves-dark"><i class="fa fa-user"></i> Beklemedekiler</a>
                    </li>

                    <li>
                        <a href="EAnasayfa.jsp?durum=Aktif" class="waves-effect waves-dark"><i class="fa fa-bars"></i> Aktifler</a>
                    </li>
                    <li>
                        <a href="EAnasayfa.jsp?durum=Raporlu" class="waves-effect waves-dark"><i class="fa fa-check-circle"></i>Raporlular</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  ALANLARIN İÇERİKLERİ BÖLÜMÜ LAYOUT-->
       	<%String durum=String.valueOf(request.getParameter("durum"));%>
       	<div id="page-wrapper">
        	<div class="header">
            	<h1 class="page-header">
                	<%if(durum.equals("Beklemede")){ %>
                		<%=durum %>ki Makaleler
                	<%}
                	if(durum.equals("Aktif") || durum.equals("Raporlu")){ %>
                		<%=durum %> Makaleler
                	<%} 
                	if(durum.equals("Alanlar")){%>
                		Makale Alanları
                	<%}%>
                </h1>
          	</div>
                 <jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
                <%
                int[] Bilgiler=Db.EDurumBilgileri();
                %>
              
                <div id="page-inner">
        				<div class="dashboard-cards">
                            <div class="row">
                                
                                <a href="EAnasayfa.jsp?durum=Beklemede">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image orange">
                                                <i class="material-icons dp48">assignment_ind</i>
                                            </div>
                                            <div class="card-stacked orange">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[0] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>BEKLEMEDEKİLER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </a>
        
                                <a href="EAnasayfa.jsp?durum=Aktif">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
        
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image blue">
                                                <i class="material-icons dp48">list</i>
                                            </div>
                                            <div class="card-stacked blue">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[2] %></h3>
                                                </div>
                                                <div class="card-action">
                                                    <strong>AKTİFLER</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </a>
        
                                <a href="EAnasayfa.jsp?durum=Raporlu">
                                    <div class="col-xs-12 col-sm-6 col-md-3">
                                        <div class="card horizontal cardIcon waves-effect waves-dark">
                                            <div class="card-image green">
                                                <i class="material-icons dp48">offline_pin</i>
                                            </div>
                                            <div class="card-stacked green">
                                                <div class="card-content">
                                                    <h3><%=Bilgiler[1] %></h3>
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
       	
       	<a class="btn btn-success btn-sm" href="EAnasayfa.jsp?durum=Alanlar" role="button">Makale Alanları</a>
       	
       	<div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="card">
                    <div class="card-action">
                    <%if(durum.equals("Aktif")){ %>
                    	<a class="btn btn-primary btn-sm" href="EAnasayfa.jsp?durum=Aktif&filtre=Teklif" role="button">Tekliftekiler</a>
                    	<a class="btn btn-success btn-sm" href="EAnasayfa.jsp?durum=Aktif&filtre=Evet" role="button">Kabul edilenler</a>
                    	<a class="btn btn-danger btn-sm" href="EAnasayfa.jsp?durum=Aktif&filtre=Hayır" role="button">Ret edilenler</a>
                	<%}
                    if(durum.equals("Alanlar")){ %>
	                	<a class="btn btn-success btn-sm" href="AlanEkle.jsp" role="button">Ekle</a>
	                <%}
                    String filtre=String.valueOf(request.getParameter("filtre"));
                    System.out.print("Filtre: "+ filtre);
                    %>
                   	
                   	<%if(!durum.equals("Alanlar")){ %>    
                       <form class="form-inline" action="EAnasayfa.jsp">
							<input type="hidden" name="durum" value="<%=durum%>">
							<input type="hidden" name="filtre" value="<%=filtre%>">		 
							 <div class="form-group mx-sm-3 mb-2">
							    <input type="text" class="form-control" name="kelime" placeholder="Başlığa Göre Ara"> <!-- Hepsinde aynı -->
							  </div>
							  <button type="submit" class="btn btn-primary mb-2">Ara</button>
						</form>
					<%}%>
                    
                    </div>
                    <div class="card-content">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
	                                   <%if(durum.equals("Beklemede")){ %>
	                                    	<th>Id</th>
	                                        <th>Başlık</th>
	                                        <th>Yazar</th>
	                                        <th>Alan</th>
	                                        <th>Durum</th>
	                                        <th>Makale</th>
	                                        <th>Teklif</th>
	                                    <%}
	                                   	if(durum.equals("Aktif")){
											if(filtre.equals("Teklif")){
												Db.TKontrol();
											%>
	                                   			<th>Id</th>
		                                        <th>Başlık</th>
		                                        <th>Teklif Gönderen Editör Adı</th>
		                                        <th>Teklif Alan Hakem Adı</th>
		                                        <th>Durum</th>
		                                        <th>Makale</th>
		                                    <%}
											
											if(filtre.equals("Evet")){
												Db.RHatirlatma();
											%>
												<th>Id</th>
		                                        <th>Başlık</th>
		                                        <th>Teklif Gönderen Editör Adı</th>
			                                  	<th>Teklif Alan Hakem Adı</th>
		                                        <th>Durum</th>
		                                        <th>Makale</th>
		                                        <th>Son Teslim Tarihi</th>
											<%}	
	                                   		
											if(filtre.equals("Hayır")){%>
		                                    	<th>Id</th>
		                                        <th>Başlık</th>
		                                        <th>Teklif Gönderen Editör Adı</th>
		                                        <th>Teklif Alan Hakem Adı</th>
		                                        <th>Durum</th>
		                                        <th>Makale</th>
		                                        <th>Teklif</th>
	                                    	<%}
											
											if(filtre.equals("null")){%>
		                                    	<th>Id</th>
		                                        <th>Başlık</th>
		                                        <th>Teklif Gönderen Editör Adı</th>
		                                        <th>Teklif Alan Hakem Adı</th>
		                                        <th>Durum</th>
		                                        <th>Makale</th>
	                                    	<%}
	                                   	}
	                                   	if(durum.equals("Raporlu")){%>
	                                   		<th>Id</th>
	                                        <th>Başlık</th>
	                                        <th>Teklif Gönderen Editör Adı</th>
		                                  	<th>Teklif Alan Hakem Adı</th>
	                                        <th>Durum</th>
	                                        <th>Makale</th>
	                                        <th>Rapor</th>
	                                        <th>Son Teslim Tarihi</th>
	                                    <%}
	                                   	if(durum.equals("Alanlar")){%>
	                                    	<th>Id</th>
	                                        <th>Başlık</th>
	                                    <%}%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    ResultSet Rs=Db.EBeklemedekiMakaleGetir(String.valueOf(request.getParameter("kelime")));
                                    
                                   	if(durum.equals("Beklemede")){
                                    	Rs=Db.EBeklemedekiMakaleGetir(String.valueOf(request.getParameter("kelime")));
                                    }
                                    
                                   	if(durum.equals("Aktif")){
                                    	Rs=Db.AktfiMakaleler(String.valueOf(request.getParameter("kelime")));
                                    }
                                   	
                                   	if(durum.equals("Raporlu")){
                                    	Rs=Db.RaporluMakaleler(String.valueOf(request.getParameter("kelime")));
                                    }
                                   	
                                   	if(durum.equals("Alanlar")){
                                    	Rs=Db.AlanGetir();
                                    }
                                    
                                    while(Rs.next()){
                                    	if(durum.equals("Beklemede")){%>
                                    		<tr>	
		                                    	<td><%=Rs.getString("id")%></td>
		                                        <td><%=Rs.getString("baslik")%></td>
		                                        <td><%=Rs.getString("yad")%></td>
		                                        <td><%=Rs.getString("aad")%></td>
		                                        <td><%=Rs.getString("durum")%></td>
		                                        <td><a href="articals/<%=Rs.getString("ad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
		                                        <td>
		                                        	<a class="btn btn-primary btn-sm" href="MakaleTeklif.jsp?id=<%=Rs.getString("id")%>" role="button">Teklif Gönder</a>
		                                        </td>
	                                 		</tr>
	                                    <%}
	                                    if(durum.equals("Aktif")){
	                                    	if(!filtre.equals("null")){
		                                    	if(filtre.equals(String.valueOf(Rs.getString("durum")))){
		                                    		
		                                    		if(filtre.equals("Teklif")){%>
					                                    <tr> 
					                                    	<td><%=Rs.getString("id")%></td>
						                                    <td><%=Rs.getString("baslik")%></td>
						                                    <td><%=Rs.getString("editorad")%></td>
						                                    <td><%=Rs.getString("hakemad")%></td>
						                                    <td><%=Rs.getString("durum")%></td>
					                                    	<td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
					                                    </tr>
	                                    			<%}
		                                    		
		                                    		if(filtre.equals("Evet")){%>
		                                    			<tr> 
					                                    	<td><%=Rs.getString("id")%></td>
						                                    <td><%=Rs.getString("baslik")%></td>
						                                    <td><%=Rs.getString("editorad")%></td>
						                                    <td><%=Rs.getString("hakemad")%></td>
													   <%-- <td><%=Rs.getString("durum")%></td> --%>
															<td>Kabul edildi</td>
					                                    	<td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
					                                    	<td><%=Rs.getString("kabultarihi")%></td>
					                                    </tr>
				                            		<%}
		                                    		
		                                    		if(filtre.equals("Hayır")){%>
					                                    <tr> 
					                                    	<td><%=Rs.getString("id")%></td>
						                                    <td><%=Rs.getString("baslik")%></td>
						                                    <td><%=Rs.getString("editorad")%></td>
						                                    <td><%=Rs.getString("hakemad")%></td>
						                                    <%-- <td><%=Rs.getString("durum")%></td> --%>
															<td>Ret edildi</td>
					                                    	<td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
					                                    	<td>
		                                        				<a class="btn btn-primary btn-sm" href="MakaleTeklif.jsp?id=<%=Rs.getString("id")%>" role="button">Teklif Gönder</a>
		                                        			</td>
					                                    </tr>
		                                    		<%}
		                                    		
		                                    	}
		                                    }
	                                    	else{%>
		                                    	<tr> 
			                                    	<td><%=Rs.getString("id")%></td>
					                               	<td><%=Rs.getString("baslik")%></td>
					                        		<td><%=Rs.getString("editorad")%></td>
					                             	<td><%=Rs.getString("hakemad")%></td>
					                            	<%-- <td><%=Rs.getString("durum")%></td> --%>
					                            	<%if(Rs.getString("durum").equals("Evet")){ %>
					                            		<td>Kabul edildi</td>
				                             		<%}
					                            	if(Rs.getString("durum").equals("Hayır")){
					                            	%>
				                             			<td>Ret edildi</td>
				                             		<%}if(Rs.getString("durum").equals("Teklif")){ %>
				                             			<td><%=Rs.getString("durum")%></td>
				                             		<%} %>
				                             		
				                             		<td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
				                              	</tr>
	                                    	<%}
	                                    }
	                                    if(durum.equals("Raporlu")){%>
	                                    	<tr> 
		                                    	<td><%=Rs.getString("makale_id")%></td>
					                           	<td><%=Rs.getString("baslik")%></td>
					                			<td><%=Rs.getString("ead")%></td>
					                    		<td><%=Rs.getString("had")%></td>
					                      		<td><%=Rs.getString("durum")%></td>
				                     			<td><a href="articals/<%=Rs.getString("mad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
				                     			<td><a href="articals/<%=Rs.getString("raporad")%>" target="_blank" style="text-decoration: none;"><img alt="Qries" src="assets/pdf_image.png" width=70"></a></td>
				                      			<td><%=Rs.getString("kabultarihi")%></td>
		                                    </tr>
		                          		<%}
	                                    if(durum.equals("Alanlar")){%>
	                                   		<tr> 
		                                    	<td><%=Rs.getString("id")%></td>
			                                    <td><%=Rs.getString("ad")%></td>
			                                    <td>
				                                    <a class="btn btn-warning btn-sm" href="AlanGuncelle.jsp?id=<%=Rs.getString("id")%>" role="button">Güncelle</a>
				                                    <a class="btn btn-danger btn-sm" href="AlanSil.jsp?id=<%=Rs.getString("id")%>" role="button">Sil</a>
			                                    </td>
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