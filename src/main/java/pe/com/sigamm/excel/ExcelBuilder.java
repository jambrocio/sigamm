package pe.com.sigamm.excel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFPalette;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import pe.com.sigamm.modelo.Socio;

public class ExcelBuilder extends AbstractExcelView{
	
	private CellStyle csRight = null;
	private CellStyle csRightP = null;
	private CellStyle csTitulo = null;
	private CellStyle csCabecera = null;
	
	@Override
    protected void buildExcelDocument(Map<String, Object> model,
            HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // get data model which is passed by the Spring container
        List<Socio> listaRegistros = (List<Socio>) model.get("listaRegistros");
         
        // create a new Excel sheet
        HSSFSheet sheet = workbook.createSheet("Registros");
        sheet.setDefaultColumnWidth(30);
        
        //Estilo Cabecera
  		Font bCabecera = workbook.createFont();
  		bCabecera.setFontName("Arial");
  		bCabecera.setBoldweight(Font.BOLDWEIGHT_BOLD);
  		bCabecera.setFontHeightInPoints((short) 10);
  		bCabecera.setColor(HSSFColor.WHITE.index);
        
  	  	csCabecera = workbook.createCellStyle();
  	  	csCabecera.setFont(bCabecera);
  	  	csCabecera.setBorderTop(CellStyle.BORDER_THIN);
  	  	csCabecera.setTopBorderColor(IndexedColors.BLACK.getIndex());
  	  	csCabecera.setBorderBottom(CellStyle.BORDER_THIN);
  	  	csCabecera.setBottomBorderColor(IndexedColors.BLACK.getIndex());
  	  	csCabecera.setBorderRight(CellStyle.BORDER_THIN);
  	  	csCabecera.setRightBorderColor(IndexedColors.BLACK.getIndex());
  	  	
  	  	HSSFWorkbook hwb = new HSSFWorkbook();
  	  	HSSFPalette palette = hwb.getCustomPalette();
  		// get the color which most closely matches the color you want to use
  		HSSFColor myColor = palette.findSimilarColor(11, 115, 158);
  		// get the palette index of that color 
		short palIndex = myColor.getIndex();
  		// code to get the style for the cell goes here
  		//style.setFillForegroundColor(palIndex);
  	  	
  	  	//csCabecera.setFillForegroundColor(HSSFColor.BLUE.index);
		csCabecera.setFillForegroundColor(palIndex);
  	  	csCabecera.setFillPattern(CellStyle.SOLID_FOREGROUND);
      
        //Estilo Derecha
	  	Font fRight = workbook.createFont();
	  	fRight.setFontHeightInPoints((short) 10);
        csRight = workbook.createCellStyle();
		csRight.setBorderRight(CellStyle.BORDER_THIN);
		csRight.setRightBorderColor(IndexedColors.BLACK.getIndex());
		csRight.setBorderBottom(CellStyle.BORDER_THIN);
		csRight.setBottomBorderColor(IndexedColors.BLACK.getIndex());
  	  	csRight.setFont(fRight);
		
		csRightP = workbook.createCellStyle();
		csRightP.setBorderRight(CellStyle.BORDER_THIN);
		csRightP.setRightBorderColor(IndexedColors.BLACK.getIndex());
		csRightP.setBorderBottom(CellStyle.BORDER_THIN);
		csRightP.setBottomBorderColor(IndexedColors.BLACK.getIndex());
  	  	csRightP.setDataFormat(workbook.createDataFormat().getFormat("#,##0.00"));
		csRightP.setFont(fRight);
		
        // create header row
        HSSFRow header = sheet.createRow(0);
        
        header.createCell(0).setCellValue("Nro.");
        header.getCell(0).setCellStyle(csCabecera);
        
        header.createCell(1).setCellValue("DNI");
        header.getCell(1).setCellStyle(csCabecera);
         
        header.createCell(2).setCellValue("Nombres");
        header.getCell(2).setCellStyle(csCabecera);
         
        header.createCell(3).setCellValue("Giro");
        header.getCell(3).setCellStyle(csCabecera);
         
        header.createCell(4).setCellValue("Fecha Ingreso");
        header.getCell(4).setCellStyle(csCabecera);
         
        header.createCell(5).setCellValue("Padron");
        header.getCell(5).setCellStyle(csCabecera);
        
        header.createCell(6).setCellValue("Puesto");
        header.getCell(6).setCellStyle(csCabecera);
        
        header.createCell(7).setCellValue("Sector");
        header.getCell(7).setCellStyle(csCabecera);
        
        // create data rows
        int rowCount = 1;
         
        for (Socio socio : listaRegistros) {
        	
        	Cell c = null;
            HSSFRow aRow = sheet.createRow(rowCount++);
            
            c = aRow.createCell(0);
    		c.setCellValue(String.valueOf(rowCount - 1));
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(1);
    		c.setCellValue(socio.getDni());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(2);
    		c.setCellValue(socio.getNombreFull());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(3);
    		c.setCellValue(socio.getNombreGiro());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(4);
    		c.setCellValue(socio.getFechaIngreso());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(5);
    		c.setCellValue(socio.getPadron());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(6);
    		c.setCellValue(socio.getNroPuesto());
    		c.setCellStyle(csRight);
    		
    		c = aRow.createCell(7);
    		c.setCellValue(socio.getNombreSector());
    		c.setCellStyle(csRight);
    		
        }
    }
}
