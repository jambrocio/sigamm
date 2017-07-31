package pe.com.sigamm.busImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.bus.ReciboLuzSocioBus;
import pe.com.sigamm.dao.PuestoDao;
import pe.com.sigamm.dao.ReciboLuzSocioDao;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.util.UtilPDF;

@Service
public class ReciboLuzSocioBusImpl implements ReciboLuzSocioBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzSocioBusImpl.class);

	@Resource
	private ReciboLuzSocioDao reciboLuzSocioDao;

	@Resource
	private PuestoDao puestoDao;

	@Override
	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {

		return reciboLuzSocioDao.grabarReciboLuzxSocio(reciboLuzSocio);

	}
 
	@Override
	public ReporteReciboLuzSocio editarReciboLuzxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo) {

		return reciboLuzSocioDao.editarReciboLuzxSocio(pagina, registros, puestoSocio, codigoRecibo);

	}

	@Override
	public File generarFacturacionLuzPDF(Integer codigoReciboLuzSocio, String periodo) {

		Document doc = new Document();
		PdfWriter docWriter = null;
		
		String ruta_pdf_linux = System.getProperty("ruta_reportes_linux") != null ? System.getProperty("ruta_reportes_linux") : "";
		String ruta_pdf_windows = System.getProperty("ruta_reportes_windows") != null ? System.getProperty("ruta_reportes_windows") : "";		
		String sSistemaOperativo = System.getProperty("os.name");
		System.out.println(sSistemaOperativo);
		
		String path = "";
		
		if(!sSistemaOperativo.toUpperCase().contains("WINDOW")){
			path = ruta_pdf_linux + UtilPDF.getDatePDF() + ".pdf";
		}else{
			path = ruta_pdf_windows + UtilPDF.getDatePDF() + ".pdf";
		}		


		ReporteReciboLuzSocio reporte = reciboLuzSocioDao.reporteReciboLuzSocio(codigoReciboLuzSocio, periodo);

		try {
			
			docWriter = PdfWriter.getInstance(doc, new FileOutputStream(path));

			doc = UtilPDF.getAutorPDF(doc);
			doc.open();

			PdfContentByte cb = docWriter.getDirectContent();
			
			for (int aw = 0; aw < reporte.getListaReciboLuzSocio().size(); aw++) {
				
				Font fuente = new Font();
				fuente.setStyle(Font.NORMAL);
				fuente.setSize(18);
				
				Font fuente0 = new Font();
				fuente0.setStyle(Font.BOLD);
				fuente0.setSize(18);
				
				Font fuente1 = new Font();
				fuente1.setStyle(Font.BOLD);
				fuente1.setSize(20);
				
				Font fuente2 = new Font();
				fuente1.setStyle(Font.NORMAL);
				fuente1.setSize(16);
				
				Image logo = Image.getInstance(getClass().getClassLoader().getResource("imagenes/logo.png"));
				doc.add(logo);
				
				Paragraph title = new Paragraph(UtilPDF.TITULO_RECIBO, fuente);
				title.setAlignment(Element.ALIGN_CENTER);
				doc.add(title);
				
				Paragraph ruc = new Paragraph(UtilPDF.RUC, fuente);
				ruc.setAlignment(Element.ALIGN_CENTER);
				doc.add(ruc);

				Paragraph recibo = new Paragraph(UtilPDF.LEYENDA_RECIBO_LUZ + UtilPDF.getID(reporte.getListaReciboLuzSocio().get(aw).getFecPeriodo(), aw), fuente);
				recibo.setAlignment(Element.ALIGN_CENTER);
				doc.add(recibo);
				
				PdfPTable table0 = new PdfPTable(2);
				table0.setWidthPercentage(100);
				Paragraph p0 = new Paragraph("PERIODO", fuente);
				PdfPCell celda0 = new PdfPCell(p0);
				table0.addCell(celda0);
				Paragraph p1 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getFecPeriodo() + "", fuente0);
				PdfPCell celda1 = new PdfPCell(p1);
				celda1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table0.addCell(celda1);
								
				PdfPTable table1 = new PdfPTable(2);
				table1.setWidthPercentage(100);
				table1.setWidths(new int[] {60,120});
				Paragraph p2 = new Paragraph("ASOCIADO (A)", fuente);
				PdfPCell celda2 = new PdfPCell(p2);
				table1.addCell(celda2);
				Paragraph p3 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getNombreFull() + "", fuente2);
				PdfPCell celda3 = new PdfPCell(p3);
				celda3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(celda3);
				
				table1.setSpacingBefore(5);
				
				PdfPTable table2 = new PdfPTable(2);
				table2.setWidthPercentage(100);
				table2.setWidths(new int[] {60,120});
				Paragraph p4 = new Paragraph("NRO DE PUESTO", fuente);
				PdfPCell celda4 = new PdfPCell(p4);
				table2.addCell(celda4);
				Paragraph p5 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getPuestoSocio() + "", fuente);
				PdfPCell celda5 = new PdfPCell(p5);
				celda5.setHorizontalAlignment(Element.ALIGN_LEFT);
				table2.addCell(celda5);

				PdfPTable table3 = new PdfPTable(2);
				table3.setWidthPercentage(100);
				table3.setWidths(new int[] {60,120});
				Paragraph p6 = new Paragraph("SECTOR", fuente);
				PdfPCell celda6 = new PdfPCell(p6);
				table3.addCell(celda6);
				Paragraph p7 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getNombreSector() + "", fuente);
				PdfPCell celda7 = new PdfPCell(p7);
				celda7.setHorizontalAlignment(Element.ALIGN_LEFT);
				table3.addCell(celda7);
										
				PdfPTable table4 = new PdfPTable(2);
				table4.setWidthPercentage(100);
				table4.setWidths(new int[] {60,120});
				Paragraph p8 = new Paragraph("GIRO", fuente);
				PdfPCell celda8 = new PdfPCell(p8);
				table4.addCell(celda8);
				Paragraph p9 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getNombreGiro() + "", fuente);
				PdfPCell celda9 = new PdfPCell(p9);
				celda9.setHorizontalAlignment(Element.ALIGN_LEFT);
				table4.addCell(celda9);
				
				table4.setSpacingAfter(5);
				
				PdfPTable table5 = new PdfPTable(2);
				table5.setWidthPercentage(100);						
				Paragraph p10 = new Paragraph("LECTURA ANTERIOR", fuente);
				PdfPCell celda10 = new PdfPCell(p10);
				table5.addCell(celda10);
				Paragraph p11 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getLecturaInicial() + "", fuente);
				PdfPCell celda11 = new PdfPCell(p11);
				celda11.setHorizontalAlignment(Element.ALIGN_CENTER);
				table5.addCell(celda11);
				
				PdfPTable table6 = new PdfPTable(2);
				table6.setWidthPercentage(100);
				Paragraph p12 = new Paragraph("LECTURA ACTUAL", fuente);
				PdfPCell celda12 = new PdfPCell(p12);
				table6.addCell(celda12);
				Paragraph p13 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getLecturaFinal() + "", fuente);
				PdfPCell celda13 = new PdfPCell(p13);
				celda13.setHorizontalAlignment(Element.ALIGN_CENTER);
				table6.addCell(celda13);
				
				PdfPTable table17 = new PdfPTable(2);
				table17.setWidthPercentage(100);
				Paragraph p34 = new Paragraph("CONSUMO MES", fuente);
				PdfPCell celda34 = new PdfPCell(p34);
				table17.addCell(celda34);
				Paragraph p35 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getConsumoMes() + "", fuente);
				PdfPCell celda35 = new PdfPCell(p35);
				celda35.setHorizontalAlignment(Element.ALIGN_CENTER);
				table17.addCell(celda35);
				
				table17.setSpacingAfter(5);
				
				PdfPTable table7 = new PdfPTable(2);
				table7.setWidthPercentage(100);
				Paragraph p14 = new Paragraph("CARGO POR ENERGIA", fuente);
				PdfPCell celda14 = new PdfPCell(p14);
				table7.addCell(celda14);
				Paragraph p15 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getCargoEnergia(), 2) + "", fuente);
				PdfPCell celda15 = new PdfPCell(p15);
				celda15.setHorizontalAlignment(Element.ALIGN_CENTER);
				table7.addCell(celda15);
				
				PdfPTable table16 = new PdfPTable(2);
				table16.setWidthPercentage(100);
				Paragraph p32 = new Paragraph("CARGO POR IMPUESTO", fuente);
				PdfPCell celda32 = new PdfPCell(p32);
				table16.addCell(celda32);
				Paragraph p33 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getIgvCargo(), 2) + "", fuente);
				PdfPCell celda33 = new PdfPCell(p33);
				celda33.setHorizontalAlignment(Element.ALIGN_CENTER);
				table16.addCell(celda33);
				
				PdfPTable table8 = new PdfPTable(2);
				table8.setWidthPercentage(100);
				Paragraph p16 = new Paragraph("ALUMBRADO PUBLICO", fuente);
				PdfPCell celda16 = new PdfPCell(p16);
				table8.addCell(celda16);
				Paragraph p17 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getAlumbradoPublico(), 2) + "", fuente);
				PdfPCell celda17 = new PdfPCell(p17);
				celda17.setHorizontalAlignment(Element.ALIGN_CENTER);
				table8.addCell(celda17);
				
				PdfPTable table9 = new PdfPTable(2);
				table9.setWidthPercentage(100);
				Paragraph p18 = new Paragraph("CARGO FIJO", fuente);
				PdfPCell celda18 = new PdfPCell(p18);
				table9.addCell(celda18);
				Paragraph p19 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getServicioMantenimiento(), 2) + "", fuente);
				PdfPCell celda19 = new PdfPCell(p19);
				celda19.setHorizontalAlignment(Element.ALIGN_CENTER);
				table9.addCell(celda19);
				
				PdfPTable table10 = new PdfPTable(2);
				table10.setWidthPercentage(100);
				Paragraph p20 = new Paragraph("DEUDA ANTERIOR", fuente);
				PdfPCell celda20 = new PdfPCell(p20);
				table10.addCell(celda20);
				Paragraph p21 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getDeudaAnterior(), 2) + "", fuente);
				PdfPCell celda21 = new PdfPCell(p21);
				celda21.setHorizontalAlignment(Element.ALIGN_CENTER);
				table10.addCell(celda21);
				
				PdfPTable table11 = new PdfPTable(2);
				table11.setWidthPercentage(100);
				Paragraph p22 = new Paragraph("RECONEXION", fuente);
				PdfPCell celda22 = new PdfPCell(p22);
				table11.addCell(celda22);
				Paragraph p23 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getReconexion(), 2) + "", fuente);
				PdfPCell celda23 = new PdfPCell(p23);
				celda23.setHorizontalAlignment(Element.ALIGN_CENTER);
				table11.addCell(celda23);
				
				PdfPTable table12 = new PdfPTable(2);
				table12.setWidthPercentage(100);
				Paragraph p24 = new Paragraph("OTROS", fuente);
				PdfPCell celda24 = new PdfPCell(p24);
				table12.addCell(celda24);
				Paragraph p25 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getCableadoPrincipal(), 2) + "", fuente);
				PdfPCell celda25 = new PdfPCell(p25);
				celda25.setHorizontalAlignment(Element.ALIGN_CENTER);
				table12.addCell(celda25);
				
				table12.setSpacingAfter(5);
				//----------------------------------------------
				PdfPTable table13 = new PdfPTable(2);
				table13.setWidthPercentage(100);
				Paragraph p26 = new Paragraph("TOTAL DE LUZ       (S/.)", fuente1);
				PdfPCell celda26 = new PdfPCell(p26);
				celda26.setFixedHeight(50f);
				celda26.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda26.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda26);
				
				/*Double total = 	reporte.getListaReciboLuzSocio().get(aw).getCargoEnergia() +
								reporte.getListaReciboLuzSocio().get(aw).getIgvCargo() +
								reporte.getListaReciboLuzSocio().get(aw).getAlumbradoPublico() +
								reporte.getListaReciboLuzSocio().get(aw).getServicioMantenimiento() + 
								reporte.getListaReciboLuzSocio().get(aw).getDeudaAnterior() +
								reporte.getListaReciboLuzSocio().get(aw).getReconexion() + 
								reporte.getListaReciboLuzSocio().get(aw).getCableadoPrincipal();*/
				Double total = reporte.getListaReciboLuzSocio().get(aw).getTotal();
				String valor5 = UtilPDF.round(total, 1) + "";
				//String valor5 = UtilPDF.Redondear(total, 2) + "";		
			
			    
				Paragraph p27 = new Paragraph(valor5.replace(",", "."), fuente1);
				PdfPCell celda27 = new PdfPCell(p27);
				celda27.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda27.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda27);
				//----------------------------------------------
				PdfPTable table14 = new PdfPTable(2);
				table14.setWidthPercentage(100);
				Paragraph p28 = new Paragraph("FECHA DE VENCIMIENTO", fuente1);
				PdfPCell celda28 = new PdfPCell(p28);
				celda16.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda16.setVerticalAlignment(Element.ALIGN_BOTTOM);
				celda16.setFixedHeight(50f);
				Paragraph p29 = new Paragraph("FECHA DE CORTE", fuente1);
				PdfPCell celda29 = new PdfPCell(p29);
				celda29.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda29.setVerticalAlignment(Element.ALIGN_BOTTOM);
				table14.addCell(celda28);
				table14.addCell(celda29);				
				//----------------------------------------------
				PdfPTable table15 = new PdfPTable(2);
				table15.setWidthPercentage(100);
				
				Paragraph p30 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getFechaVencimiento() + "", fuente1);
				PdfPCell celda30 = new PdfPCell(p30);
				celda16.setFixedHeight(50f);
				celda16.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda16.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table15.addCell(celda30);
				
				Paragraph p31 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getFechaCorte() + "", fuente1);
				PdfPCell celda31 = new PdfPCell(p31);
				celda31.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda31.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table15.addCell(celda31);
				//----------------------------------------------
								
				Image qrcodeImage = UtilPDF.getQRCode("PUESTO: " + reporte.getListaReciboLuzSocio().get(aw).getPuestoSocio() + "- NOMBRE: " + reporte.getListaReciboLuzSocio().get(aw).getNombreFull() + "- TOTAL A PAGAR: S/. [" + valor5  + "]");
				qrcodeImage.setAbsolutePosition(500, 690);
				doc.add(qrcodeImage);
				
				doc.add(table1);
				doc.add(table2);
				doc.add(table3);
				doc.add(table4);
				doc.add(table0);
				doc.add(table5);
				doc.add(table6);
				doc.add(table17);
				doc.add(table7);
				doc.add(table16);				
				doc.add(table8);
				doc.add(table9);
				doc.add(table10);
				doc.add(table11);
				doc.add(table12);
				doc.add(table13);
				doc.add(table14);
				doc.add(table15);
				
				Paragraph observaciones = new Paragraph("OBSERVACIONES:");
				Paragraph observacionesDetalle = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getObservaciones() + "");
				
				observaciones.setSpacingBefore(5);
				
				doc.add(observaciones);
				doc.add(observacionesDetalle);
				doc.newPage();
				
			}

		} catch (Exception e) {
			log.error("Ocurrio un error al generar PDF");
		} finally {
			if (doc != null) {
				doc.close();
			}
			if (docWriter != null) {
				docWriter.close();
			}
		}

		File file = new File(path);
		return file;

	}

	@Override
	public Retorno pagarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {

		return reciboLuzSocioDao.pagarReciboLuzxSocio(reciboLuzSocio);
		
	}

	@Override
	public Retorno eliminarReciboLuzSocio(ReciboLuzSocio reciboLuzSocio) {

		return reciboLuzSocioDao.eliminarReciboLuzxSocio(reciboLuzSocio);
	}

}
