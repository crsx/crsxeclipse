package net.sf.crsx.xtext.ui.syntaxcoloring;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor;
import org.eclipse.xtext.ui.editor.utils.TextStyle;

public class CrsxHighlightingConfiguration extends
		DefaultHighlightingConfiguration {

	public static final String METAVAR_ID = "Meta variable";
	public static final String FUNCTION_SORT_ID = "Function sort";
	public static final String DATA_SORT_ID = "Data sort";
	public static final String FUNCTION_ID = "Function";
	public static final String DATA_ID = "Data";
	public static final String PRIMITIVE_ID = "Primitive";

	public CrsxHighlightingConfiguration() {
		super();
	}

	@Override
	public void configure(IHighlightingConfigurationAcceptor acceptor) {
		super.configure(acceptor);
		acceptor.acceptDefaultHighlighting(METAVAR_ID, METAVAR_ID,
				metaTextStyle());
		acceptor.acceptDefaultHighlighting(FUNCTION_SORT_ID, FUNCTION_SORT_ID,
				functionSortTextStyle());
		acceptor.acceptDefaultHighlighting(DATA_SORT_ID, DATA_SORT_ID,
				dataSortTextStyle());
		// acceptor.acceptDefaultHighlighting(FUNCTION_ID, FUNCTION_ID,
		// functionTextStyle());
		// acceptor.acceptDefaultHighlighting(DATA_ID, DATA_ID,
		// dataTextStyle());

		acceptor.acceptDefaultHighlighting(PRIMITIVE_ID, PRIMITIVE_ID,
				primitiveTextStyle());
	}

	private TextStyle primitiveTextStyle() {
		return keywordTextStyle();
	}

	public TextStyle metaTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(22, 109, 199));
		return textStyle;
	}

	public TextStyle functionSortTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setStyle(SWT.BOLD);
		textStyle.setColor(new RGB(96, 0, 211));
		return textStyle;
	}

	public TextStyle dataSortTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setStyle(SWT.BOLD);
		return textStyle;
	}

	public TextStyle functionTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(96, 0, 211));
		return textStyle;
	}

	public TextStyle dataTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		return textStyle;
	}
}
