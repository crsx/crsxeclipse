package net.sf.crsx.xtext.ui.syntaxcoloring;

import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultAntlrTokenToAttributeIdMapper;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;

/**
 * 
 * @author villardl
 */
public class CrsxTokenToAttributeIdMapper extends
		DefaultAntlrTokenToAttributeIdMapper {

	public CrsxTokenToAttributeIdMapper() {
		super();
	}

	@Override
	protected String calculateId(String tokenName, int tokenType) {
		if (tokenName.equals("RULE_XML_COMMENT"))
			return DefaultHighlightingConfiguration.COMMENT_ID;
		if (tokenName.equals("RULE_METAVARIABLE"))
			return CrsxHighlightingConfiguration.METAVAR_ID;
		return super.calculateId(tokenName, tokenType);
	}

}
