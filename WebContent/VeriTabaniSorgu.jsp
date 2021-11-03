<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />

<%
String Islem=request.getParameter("islem");

//Giriş
if(Islem.equals("Giris")){
	String ad="", sifre="";
	
	String Alan=request.getParameter("alan");	
	
	if(Alan.equals("yazarlar")){
		ad=request.getParameter("y_ka");
		sifre=request.getParameter("y_s");
	}
	
	if(Alan.equals("editorler")){
		ad=request.getParameter("e_ka");
		sifre=request.getParameter("e_s");
	}
	
	if(Alan.equals("hakemler")){
		ad=request.getParameter("h_ka");
		sifre=request.getParameter("h_s");
	}
	
	String[] GKBilgisi=Db.GirisKontrol(ad, sifre, Alan);
	
	if(GKBilgisi[2]=="true"){
		
		if(Alan.equals("yazarlar")){
			session.setAttribute("AYId",GKBilgisi[0]);
			session.setAttribute("AYAd",GKBilgisi[1]);
			
			response.sendRedirect("YAnasayfa.jsp?durum=Beklemede");
		}
		
		if(Alan.equals("editorler")){
			session.setAttribute("AEId",GKBilgisi[0]);
			session.setAttribute("AEAd",GKBilgisi[1]);
			
			response.sendRedirect("EAnasayfa.jsp?durum=Beklemede");
		}
		
		if(Alan.equals("hakemler")){
			session.setAttribute("AHId",GKBilgisi[0]);
			session.setAttribute("AHAd",GKBilgisi[1]);
			
			response.sendRedirect("HAnasayfa.jsp?durum=Teklif");
		}
	}
		
	else{
		
		if(Alan.equals("yazarlar")){
			session.setAttribute("y_login",GKBilgisi[2]);
		}
		
		if(Alan.equals("editorler")){
			session.setAttribute("e_login",GKBilgisi[2]);
		}
		
		if(Alan.equals("hakemler")){
			session.setAttribute("h_login",GKBilgisi[2]);
		}
		
		response.sendRedirect("index.jsp");
	}
		  
}


//MailSifre
if(Islem.equals("SifreAl")){
	String Eposta=request.getParameter("k_eposta");
	String Alan=request.getParameter("alan");
	Boolean durum= Db.EMailGonder(Eposta, Alan);
	
	if(durum.equals(false)){
		session.setAttribute("MSifre", "false");
		response.sendRedirect("SifremiUnuttum.jsp?alan="+Alan); 
	}
	if(durum.equals(true))
		response.sendRedirect("index.jsp"); 
}

//MailSifre Yenileme
if(Islem.equals("EmailSifre")){
	String YeniSid=request.getParameter("ys_id");
	String YeniSalan=request.getParameter("ys_alan");
	
	String YeniS=request.getParameter("ys");
	String YeniST=request.getParameter("yst");
	
	if(YeniS.equals(YeniST)){
		Db.SifreEposta(YeniS, YeniSid, YeniSalan);
		response.sendRedirect("index.jsp"); 
	}
	else{
		session.setAttribute("MYS", "false");
		response.sendRedirect("YeniSifre.jsp?id="+YeniSid+"&alan="+YeniSalan); 
	}
}


//Yazar Hakem kayıt
if(Islem.equals("Kayit")){
	String Alan=request.getParameter("kalan");
	Boolean Durum=true;
	
	if(Alan.equals("YazarKayit.jsp")){
		String YAd=request.getParameter("y_ad");
		String YSifre=request.getParameter("y_sifre");
		String YEmail=request.getParameter("y_email");
		
		Durum=Db.YazarKayit(YAd, YSifre, YEmail);
	}
	
	if(Alan.equals("HakemKayit.jsp")){
		String HAd=request.getParameter("h_ad");
		String HSifre=request.getParameter("h_sifre");
		String HTc=request.getParameter("h_tc");
		String HAlan=request.getParameter("h_alan");
		String HEmail=request.getParameter("h_eposta");
		
		Durum=Db.HakemKayit(HAd, HSifre, HTc, HAlan, HEmail);
	}
	
	System.out.println("Durum: "+Durum);
	
	if(Durum.equals(true))
		response.sendRedirect("index.jsp");
	else{
		response.sendRedirect(Alan);
		session.setAttribute("KHata", "false");
	}
}

//Sifre Guncelleme
if(Islem.equals("SifreGuncelle")){
	String ASifre=request.getParameter("asifre");
	String YSifre=request.getParameter("ysifre"); 
	String YSifreT=request.getParameter("ysifret");
	
	String id=request.getParameter("id");
	String alan=request.getParameter("alan");
	
	Boolean Sonuc=true;
	
	if(YSifre.equals(YSifreT)){
		Sonuc=Db.SifreGuncelle(YSifre, ASifre, id, alan);
		
		if(Sonuc.equals(true)){
			if(alan.equals("yazarlar"))
				response.sendRedirect("YAnasayfa.jsp?durum=Beklemede");
		
			if(alan.equals("editorler"))
				response.sendRedirect("EAnasayfa.jsp?durum=Beklemede");
			
			if(alan.equals("hakemler"))
				response.sendRedirect("HAnasayfa.jsp?durum=Teklif");
		}
		
		else{
			session.setAttribute("SifreDH", "false");
			response.sendRedirect("SifreDegistir.jsp?id="+id+"&alan="+alan);  
		}
	}
	else{
		session.setAttribute("SifreDH", "false");
		response.sendRedirect("SifreDegistir.jsp?id="+id+"&alan="+alan);   
	}
}




//Çıkış
if(Islem.equals("cikis")){
	String alan=request.getParameter("alan");
	
	if(alan.equals("yazarlar")){
		session.setAttribute("AYId", null);
		session.setAttribute("AYAd", null);
	}
	
	if(alan.equals("editorler")){
		session.setAttribute("AEId", null);
		session.setAttribute("AEAd", null);
	}
	
	if(alan.equals("hakemler")){
		session.setAttribute("AHId", null);
		session.setAttribute("AHAd", null);
	}
	
	response.sendRedirect("index.jsp");  
}

// Yazarlar---------------------------------------------------------

if(Islem.equals("MakaleEkleGuncelle")){
	String Baslik=request.getParameter("m_b");
	String Alanid=request.getParameter("m_a_id");
	String Yazarid=String.valueOf(session.getAttribute("AYId"));
	String MakaleA=String.valueOf(session.getAttribute("makale_adi"));
	
	if(request.getParameter("guncelle").equals("yok")){
		
		Db.MakaleEG(MakaleA, Baslik, Alanid, Yazarid, "-1", "yok");
	}
	else{
		if(session.getAttribute("makale_adi")==null)
			MakaleA=String.valueOf(session.getAttribute("makale_tut"));
		
		Db.MakaleEG(MakaleA, Baslik, Alanid, Yazarid, request.getParameter("gid"), "evet");
	}
	response.sendRedirect("YAnasayfa.jsp?durum=Beklemede");
	
	session.setAttribute("makale_guncelle", "yok");
	session.setAttribute("makale_adi", null);
	
}

//Editörler------------------------------------------------------------

//AlanEkleGuncelle
if(Islem.equals("AlanEkleGuncelle")){
	String Ad=request.getParameter("a_ad");
	
	if(request.getParameter("guncelle").equals("yok"))
		Db.AlanEG(Ad, "-1", "yok");
	
	else
		Db.AlanEG(Ad,request.getParameter("gid"), "evet");
	
	response.sendRedirect("EAnasayfa.jsp?durum=Alanlar");
}

//HakemTeklif
if(Islem.equals("HakemTeklif")){
	String Editorid=String.valueOf(session.getAttribute("AEId"));
	String Hakemid=request.getParameter("hid");
	String Makaleid=request.getParameter("mid");
	
	Db.TeklifGonder(Editorid, Hakemid, Makaleid);
	
	response.sendRedirect("EAnasayfa.jsp?durum=Beklemede");
}

//Hakemler--------------------------------------------------------------

//Rapor Yükleme
if(Islem.equals("MakaleRaporEkle")){
	String RaporA=String.valueOf(session.getAttribute("makale_adi"));
	String mid=request.getParameter("mid");
	String tid=request.getParameter("tid");
	
	Db.RaporYukle(RaporA, mid, tid);
	
	session.setAttribute("makale_adi", null);
	session.setAttribute("makale_rapor", "yok");
	
	response.sendRedirect("HAnasayfa.jsp?durum=Raporlu");
}





























%>