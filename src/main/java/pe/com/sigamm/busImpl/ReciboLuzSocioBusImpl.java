package pe.com.sigamm.busImpl;

import java.io.File;
import java.io.FileOutputStream;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
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
	private static final Logger log = Logger
			.getLogger(ReciboLuzSocioBusImpl.class);

	@Resource
	private ReciboLuzSocioDao reciboLuzSocioDao;

	@Resource
	private PuestoDao puestoDao;

	@Override
	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {

		return reciboLuzSocioDao.grabarReciboLuzxSocio(reciboLuzSocio);

	}

	@Override
	public ReporteReciboLuzSocio editarReciboLuzxSocio(int pagina,
			int registros, String puestoSocio, int codigoRecibo) {

		return reciboLuzSocioDao.editarReciboLuzxSocio(pagina, registros,
				puestoSocio, codigoRecibo);

	}

	@Override
	public File generarFacturacionLuzPDF(Integer codigoReciboLuzSocio,
			String periodo) {

		Document doc = new Document();
		PdfWriter docWriter = null;
		String path = UtilPDF.RUTA_PDF + UtilPDF.getDatePDF() + ".pdf";

		ReporteReciboLuzSocio reporte = reciboLuzSocioDao
				.reporteReciboLuzSocio(codigoReciboLuzSocio, periodo);

		try {
			
			docWriter = PdfWriter.getInstance(doc, new FileOutputStream(path));

			doc = UtilPDF.getAutorPDF(doc);
			doc.open();

			PdfContentByte cb = docWriter.getDirectContent();
			
			for (int aw = 0; aw < reporte.getListaReciboLuzSocio().size(); aw++) {
				
				Image logo = Image.getInstance(getClass().getClassLoader().getResource("imagenes/logo.png"));
				doc.add(logo);
				
				Paragraph title = new Paragraph(UtilPDF.TITULO_RECIBO);
				title.setAlignment(Element.ALIGN_CENTER);
				doc.add(title);
				
				Paragraph ruc = new Paragraph(UtilPDF.RUC);
				ruc.setAlignment(Element.ALIGN_CENTER);
				doc.add(ruc);

				Paragraph recibo = new Paragraph(UtilPDF.LEYENDA_RECIBO + reporte.getListaReciboLuzSocio().get(aw).getIdRecibo());
				recibo.setAlignment(Element.ALIGN_CENTER);
				doc.add(recibo);
				
				Image qrcodeImage = UtilPDF.getQRCode(reporte.getListaReciboLuzSocio().get(aw).getIdRecibo() + "");
				qrcodeImage.setAlignment(Element.ALIGN_CENTER);
				doc.add(qrcodeImage);
				
				PdfPTable table0 = new PdfPTable(2);
				table0.setWidthPercentage(100);
				table0.addCell("ASOCIADO (A)");
				table0.addCell(reporte.getListaReciboLuzSocio().get(aw).getNombreFull() + "");
				
				PdfPTable table1 = new PdfPTable(2);
				table1.setWidthPercentage(100);
				table1.addCell("N° DE PUESTO");
				table1.addCell(reporte.getListaReciboLuzSocio().get(aw).getPuestoSocio() + "");
				
				PdfPTable table3 = new PdfPTable(2);
				table3.setWidthPercentage(100);				
				table3.addCell("SECTOR");
				table3.addCell(reporte.getListaReciboLuzSocio().get(aw).getNombreSector() + "");
								
				PdfPTable table4 = new PdfPTable(2);
				table4.setWidthPercentage(100);						
				table4.addCell("GIRO");		
				table4.addCell(reporte.getListaReciboLuzSocio().get(aw).getNombreGiro() + "");
				
				table4.setSpacingAfter(20);
				
				PdfPTable table5 = new PdfPTable(2);
				table5.setWidthPercentage(100);
				table5.addCell("PERIODO");
				table5.addCell(reporte.getListaReciboLuzSocio().get(aw).getFecPeriodo() + "");
				
				PdfPTable table6 = new PdfPTable(2);
				table6.setWidthPercentage(100);						
				table6.addCell("LECTURA ANTERIOR");		
				Paragraph p6 = new Paragraph((reporte.getListaReciboLuzSocio().get(aw).getLecturaInicial() + ""));
				PdfPCell celda6 = new PdfPCell(p6);
				celda6.setHorizontalAlignment(Element.ALIGN_CENTER);
				table6.addCell(celda6);
				
				PdfPTable table7 = new PdfPTable(2);
				table7.setWidthPercentage(100);						
				table7.addCell("LECTURA ACTUAL");		
				Paragraph p7 = new Paragraph((reporte.getListaReciboLuzSocio().get(aw).getLecturaFinal() + ""));
				PdfPCell celda7 = new PdfPCell(p7);
				celda7.setHorizontalAlignment(Element.ALIGN_CENTER);
				table7.addCell(celda7);
				
				table7.setSpacingAfter(20);
				
				PdfPTable table8 = new PdfPTable(2);
				table8.setWidthPercentage(100);
				table8.addCell("CARGO POR ENERGIA");
				Paragraph p8 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getCargoEnergia(), 2) + "");
				PdfPCell celda8 = new PdfPCell(p8);
				celda8.setHorizontalAlignment(Element.ALIGN_CENTER);
				table8.addCell(celda8);
				
				PdfPTable table9 = new PdfPTable(2);
				table9.setWidthPercentage(100);
				table9.addCell("ALUMBRADO PUBLICO");
				Paragraph p9 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getAlumbradoPublico(), 2) + "");
				PdfPCell celda9 = new PdfPCell(p9);
				celda9.setHorizontalAlignment(Element.ALIGN_CENTER);
				table9.addCell(celda9);
				
				PdfPTable table10 = new PdfPTable(2);
				table10.setWidthPercentage(100);
				table10.addCell("MANTENIMIENTO");
				Paragraph p10 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getServicioMantenimiento(), 2) + "");
				PdfPCell celda10 = new PdfPCell(p10);
				celda10.setHorizontalAlignment(Element.ALIGN_CENTER);
				table10.addCell(celda10);
				
				PdfPTable table11 = new PdfPTable(2);
				table11.setWidthPercentage(100);
				table11.addCell("DEUDA ANTERIOR");
				Paragraph p11 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getDeudaAnterior(), 2) + "");
				PdfPCell celda11 = new PdfPCell(p11);
				celda11.setHorizontalAlignment(Element.ALIGN_CENTER);
				table11.addCell(celda11);
				
				PdfPTable table12 = new PdfPTable(2);
				table12.setWidthPercentage(100);
				table12.addCell("RECONEXION");
				Paragraph p12 = new Paragraph(UtilPDF.round(reporte.getListaReciboLuzSocio().get(aw).getReconexion(), 2) + "");
				PdfPCell celda12 = new PdfPCell(p12);
				celda12.setHorizontalAlignment(Element.ALIGN_CENTER);
				table12.addCell(celda12);
				
				table12.setSpacingAfter(20);
				
				PdfPTable table13 = new PdfPTable(2);
				table13.setWidthPercentage(100);
				table13.addCell("TOTAL DE LUZ");
				Double total = 	reporte.getListaReciboLuzSocio().get(aw).getCargoEnergia() +
								reporte.getListaReciboLuzSocio().get(aw).getAlumbradoPublico() +
								reporte.getListaReciboLuzSocio().get(aw).getServicioMantenimiento() + 
								reporte.getListaReciboLuzSocio().get(aw).getDeudaAnterior() +
								reporte.getListaReciboLuzSocio().get(aw).getReconexion();
				Paragraph p13 = new Paragraph(UtilPDF.round(total, 2) + "");
				PdfPCell celda13 = new PdfPCell(p13);
				celda13.setHorizontalAlignment(Element.ALIGN_CENTER);
				table13.addCell(celda13);
				
				PdfPTable table14 = new PdfPTable(2);
				table14.setWidthPercentage(100);
				table14.addCell("FECHA DE VENCIMIENTO");
				Paragraph p14 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getFechaVencimiento() + "");
				PdfPCell celda14 = new PdfPCell(p14);
				celda14.setHorizontalAlignment(Element.ALIGN_CENTER);
				table14.addCell(celda14);
				
				PdfPTable table15 = new PdfPTable(2);
				table15.setWidthPercentage(100);
				table15.addCell("FECHA DE CORTE");
				Paragraph p15 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getFechaCorte() + "");
				PdfPCell celda15 = new PdfPCell(p15);
				celda15.setHorizontalAlignment(Element.ALIGN_CENTER);
				table15.addCell(celda15);
				
				PdfPTable table16 = new PdfPTable(2);
				table16.setWidthPercentage(100);
				table16.addCell("OBSERVACIONES");
				Paragraph p16 = new Paragraph(reporte.getListaReciboLuzSocio().get(aw).getObservaciones() + "");
				PdfPCell celda16 = new PdfPCell(p16);
				celda16.setHorizontalAlignment(Element.ALIGN_CENTER);
				table16.addCell(celda16);
				
				doc.add(table0);
				doc.add(table1);
				doc.add(table3);
				doc.add(table4);
				doc.add(table5);
				doc.add(table6);
				doc.add(table7);
				doc.add(table8);
				doc.add(table9);
				doc.add(table10);
				doc.add(table11);
				doc.add(table12);
				doc.add(table13);
				doc.add(table14);
				doc.add(table15);
				doc.add(table16);
				
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

}
