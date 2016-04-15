package pe.com.sigamm.busImpl;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;

import javax.swing.RepaintManager;

public class PrintUtilities implements Printable {
	
	private Component componentToBePrinted;

	public static void printComponent(Component c) {
		new PrintUtilities(c).print();
	}

	public PrintUtilities(Component componentToBePrinted) {
		this.componentToBePrinted = componentToBePrinted;
	}
	
	public void print() {
	    PrinterJob printJob = PrinterJob.getPrinterJob();
	    printJob.setPrintable(this);
	    //if (printJob.printDialog())
	      try {
	        printJob.print();
	      } catch(PrinterException pe) {
	        System.out.println("Error printing: " + pe);
	      }
	  }
	
	@Override
	public int print(Graphics graphics, PageFormat pageFormat, int pageIndex)
			throws PrinterException {
		// TODO Auto-generated method stub
		if (pageIndex > 0) {
		      return(NO_SUCH_PAGE);
		    } else {
		      Graphics2D g2d = (Graphics2D)graphics;
		      g2d.translate(pageFormat.getImageableX(), pageFormat.getImageableY());
		      disableDoubleBuffering(componentToBePrinted);
		      componentToBePrinted.paint(g2d);
		      enableDoubleBuffering(componentToBePrinted);
		      return(PAGE_EXISTS);
		    }
	}
	  
	public static void disableDoubleBuffering(Component c) {
		RepaintManager currentManager = RepaintManager.currentManager(c);
		currentManager.setDoubleBufferingEnabled(false);
	}

	public static void enableDoubleBuffering(Component c) {
		RepaintManager currentManager = RepaintManager.currentManager(c);
		currentManager.setDoubleBufferingEnabled(true);
	}  

}
