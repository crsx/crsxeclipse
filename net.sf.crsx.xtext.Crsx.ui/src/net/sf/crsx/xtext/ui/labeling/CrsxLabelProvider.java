/*
* generated by Xtext
*/
package net.sf.crsx.xtext.ui.labeling;

import net.sf.crsx.xtext.crsx.Term;

import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider;
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider;

import com.google.inject.Inject;

/**
 * Provides labels for a EObjects.
 * 
 * see http://www.eclipse.org/Xtext/documentation/latest/xtext.html#labelProvider
 */
public class CrsxLabelProvider extends DefaultEObjectLabelProvider {

	@Inject
	public CrsxLabelProvider(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	String text(Term term)
	{
		return "Term";
	}
	
	
/*
	//Labels and icons can be computed like this:
	
	String text(MyModel ele) {
	  return "my "+ele.getName();
	}
	 
    String image(MyModel ele) {
      return "MyModel.gif";
    }
*/
}
