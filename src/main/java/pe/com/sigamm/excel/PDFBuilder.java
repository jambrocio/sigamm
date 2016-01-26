package pe.com.sigamm.excel;

import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.Usuario;
import pe.com.sigamm.util.Constantes;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFBuilder extends AbstractPdfView{
	
	private static final String sSistemaOperativo = System.getProperty("os.name") != null ? System.getProperty("os.name") :"";
	/** User password. */
    public static byte[] USER = "Hello".getBytes();
    /** Owner password. */
    public static byte[] OWNER = "World".getBytes();
    
    private static final Logger log = Logger.getLogger(PDFBuilder.class);
    
	protected void buildPdfDocument(        
            Map<String, Object> model,        
            Document document,        
            PdfWriter writer,        
            HttpServletRequest req,        
            HttpServletResponse resp)        
                    throws Exception {
 
        @SuppressWarnings("unchecked")
        Facturacion facturacion = (Facturacion) model.get("facturacion");
        
        writer = PdfWriter.getInstance(document, new FileOutputStream("Facturacion.pdf"));
        /*
        writer = PdfWriter.getInstance(document, new FileOutputStream("Reporte Resultado Elecciones.pdf"));
    	writer.setEncryption("concretepage".getBytes(), "cp123".getBytes(), PdfWriter.ALLOW_COPY, PdfWriter.STANDARD_ENCRYPTION_40);
        writer.createXmpMetadata();
        */
        /*
        PdfWriter writerr = PdfWriter.getInstance(document, new FileOutputStream("Reporte Resultado Elecciones.pdf"));
        writerr.setEncryption(USER, OWNER, PdfWriter.ALLOW_PRINTING, PdfWriter.STANDARD_ENCRYPTION_128);
        writerr.createXmpMetadata();
        */
        
        Rectangle rect = new Rectangle(30, 30, 550, 800);
        writer.setBoxSize("art", rect);
        writer.setPageEvent(new PageStamper());
        
        int registro = 1;
        Image imagen;
        PdfPTable table = new PdfPTable(3); // 3 columns.
        document.open();
        
        // -- newline
        document.add(Chunk.NEWLINE);
        
        // 1.Resultado
        Paragraph titulo = new Paragraph("Reporte Resultado Elecciones", FontFactory.getFont(
        		"arial",   						// fuente
                12,                            // tamaño
                Font.ITALIC,                   // estilo
                BaseColor.BLACK));
        
        titulo.setAlignment(1);//el 1 es para centrar
        document.add(titulo);
        document.add(new Chunk(" "));
        
        // -- newline
        document.add(Chunk.NEWLINE);
        
        float[] columnWidths = new float[] {2f, 10f, 20f};
        table.setWidths(columnWidths);
        
        PdfPCell cellSeparador1 = new PdfPCell(new Paragraph(""));
    	cellSeparador1.setBorder(Rectangle.BOTTOM);
    	cellSeparador1.setPadding(3);
    	cellSeparador1.setColspan(3);
    	cellSeparador1.setBorderWidth(2f);
    	cellSeparador1.setBorderColor(new BaseColor(52, 150, 196));
        table.addCell(cellSeparador1);
        
        PdfPCell cellNro;
    	cellNro = new PdfPCell(new Paragraph(String.valueOf(registro)));
    	cellNro.setHorizontalAlignment(Element.ALIGN_CENTER);
    	cellNro.setPadding(5);
    	cellNro.setRowspan(5);
    	//cellNro.setBorder(Rectangle.NO_BORDER);   // removes border
        table.addCell(cellNro);
        
    	Paragraph candidato = new Paragraph("CANDIDATO N° ", FontFactory.getFont(
        		"arial",   					// fuente
                8,                          // tamaño
                Font.BOLD,                  // estilo
                BaseColor.BLACK));
        
                
        /*
        for(Usuario usuario : usuarios){
        	
        	if(sSistemaOperativo.equals(Constantes.WINDOWS_OS)){
				imagen = Image.getInstance(Constantes.RUTA_FOTOS_WINDOWS + usuario.getDni() + "_100.JPG");
			}else{
				imagen = Image.getInstance(Constantes.RUTA_FOTOS_LINUX + usuario.getDni() + "_100.JPG");
			}
        	
        	PdfPCell cellSeparador1 = new PdfPCell(new Paragraph(""));
        	cellSeparador1.setBorder(Rectangle.BOTTOM);
        	cellSeparador1.setPadding(3);
        	cellSeparador1.setColspan(3);
        	cellSeparador1.setBorderWidth(2f);
        	cellSeparador1.setBorderColor(new BaseColor(52, 150, 196));
            table.addCell(cellSeparador1);
            
            PdfPCell cellNro;
        	cellNro = new PdfPCell(new Paragraph(String.valueOf(registro)));
        	cellNro.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellNro.setPadding(5);
        	cellNro.setRowspan(5);
        	cellNro.setBorder(Rectangle.NO_BORDER);   // removes border
            table.addCell(cellNro);
            
        	PdfPCell cellImagen;
        	cellImagen = new PdfPCell(imagen, false);
        	cellImagen.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellImagen.setPadding(5);
        	cellImagen.setRowspan(5);
        	cellImagen.setBorder(Rectangle.NO_BORDER);   // removes border
            table.addCell(cellImagen);
            
            Paragraph candidato = new Paragraph("CANDIDATO N° " + usuario.getOrden(), FontFactory.getFont(
            		"arial",   					// fuente
                    8,                          // tamaño
                    Font.BOLD,                  // estilo
                    BaseColor.BLACK));
            
            Paragraph nombres = new Paragraph(usuario.getNombres(), FontFactory.getFont(
            		"arial",   					// fuente
                    8,                          // tamaño
                    Font.BOLD,                  // estilo
                    BaseColor.BLACK));
                        
            Paragraph cargo = new Paragraph(usuario.getNombreRol(), FontFactory.getFont(
            		"arial",   					// fuente
                    8,                          // tamaño
                    Font.NORMAL,                // estilo
                    BaseColor.BLACK));
            
            Paragraph ut = new Paragraph(usuario.getNombreUnidad(), FontFactory.getFont(
            		"arial",   					// fuente
                    8,                          // tamaño
                    Font.NORMAL,                // estilo
                    BaseColor.BLACK));
            
            Paragraph votos = new Paragraph("VOTOS : " + usuario.getCantidadVotos(), FontFactory.getFont(
            		"arial",   					// fuente
                    8,                          // tamaño
                    Font.BOLD,                // estilo
                    BaseColor.RED));
            
            PdfPCell cellCandidato;
            cellCandidato = new PdfPCell(candidato);
            cellCandidato.setHorizontalAlignment(Element.ALIGN_CENTER);
            cellCandidato.setPadding(5);
            cellCandidato.setBorder(Rectangle.NO_BORDER);   // removes border
        	table.addCell(cellCandidato);
            
        	PdfPCell cellNombres;
        	cellNombres = new PdfPCell(nombres);
        	cellNombres.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellNombres.setPadding(5);
        	cellNombres.setBorder(Rectangle.NO_BORDER);   // removes border
        	table.addCell(cellNombres);
        	
        	PdfPCell cellCargo;
        	cellCargo = new PdfPCell(cargo);
        	cellCargo.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellCargo.setPadding(5);
        	cellCargo.setBorder(Rectangle.NO_BORDER);   // removes border
        	table.addCell(cellCargo);
        	
        	PdfPCell cellUt;
        	cellUt = new PdfPCell(ut);
        	cellUt.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellUt.setPadding(5);
        	cellUt.setBorder(Rectangle.NO_BORDER);   // removes border
        	table.addCell(cellUt);
        	
        	PdfPCell cellVotos;
        	cellVotos = new PdfPCell(votos);
        	cellVotos.setHorizontalAlignment(Element.ALIGN_CENTER);
        	cellVotos.setPadding(5);
        	cellVotos.setBorder(Rectangle.NO_BORDER);   // removes border
        	table.addCell(cellVotos);
        	
        	int resultado = registro % 4;
            registro = registro + 1;
            
            //log.info("Resultado : " + resultado);
            //log.info("Registro : " + registro);
            
            if(registro > 0 && resultado == 0){
            	
            	PdfPCell cellSeparador2 = new PdfPCell(new Paragraph(""));
            	cellSeparador2.setBorder(Rectangle.BOTTOM);
            	cellSeparador2.setPadding(5);
            	cellSeparador2.setColspan(3);
            	cellSeparador2.setBorderWidth(2f);
            	cellSeparador2.setBorderColor(new BaseColor(52, 150, 196));
                table.addCell(cellSeparador2);
                
            	document.add(table);
            	document.newPage();
            	table = new PdfPTable(3);
            	table.setWidths(columnWidths);
            	
        	}else if(registro == 32){
        		
        		PdfPCell cellSeparador2 = new PdfPCell(new Paragraph(""));
            	cellSeparador2.setBorder(Rectangle.BOTTOM);
            	cellSeparador2.setPadding(5);
            	cellSeparador2.setColspan(3);
            	cellSeparador2.setBorderWidth(2f);
            	cellSeparador2.setBorderColor(new BaseColor(52, 150, 196));
                table.addCell(cellSeparador2);
                
            	document.add(table);
            	document.newPage();
            	table = new PdfPTable(3);
            	table.setWidths(columnWidths);
        	}
            
        }
        */
        
        document.close();
        
    }
	
}
