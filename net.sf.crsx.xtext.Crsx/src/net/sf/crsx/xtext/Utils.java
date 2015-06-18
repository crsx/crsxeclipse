/* Copyright © 2012-2015 IBM Corporation. */
package net.sf.crsx.xtext;

import net.sf.crsx.xtext.crsx.Constructor;
import net.sf.crsx.xtext.crsx.Declaration;
import net.sf.crsx.xtext.crsx.Term;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;

/**
 * 
 * @author villardl
 */
public class Utils {

	/**
	 * Whether the given object is a data sort
	 * 
	 * @param eobj
	 * @return
	 */
	public static boolean isFunctionSort(EObject eobj) {
		if (eobj instanceof Declaration) {
			final Declaration decl = (Declaration) eobj;
			return "::".equals(decl.getSep()) && decl.getOptionOrTerm() != null
					&& decl.getOptionOrTerm().getConstructor() != null;
		}
		return false;
	}

	/**
	 * Gets the name of the function sort.
	 * 
	 * @param decl
	 *            A function sort
	 * @return
	 */
	public static String functionSortName(Declaration decl) {
		Constructor c = decl.getOptionOrTerm().getConstructor();
		ICompositeNode node = NodeModelUtils.getNode(c);

		return NodeModelUtils.getTokenText(node);
	}

	/**
	 * Whether the given object is a data sort
	 * 
	 * @param eobj
	 * @return
	 */
	public static boolean isDataSort(EObject eobj) {
		if (eobj instanceof Declaration) {
			final Declaration decl = (Declaration) eobj;
			return "::=".equals(decl.getSep()) && decl.getOptionOrTerm() != null
					&& decl.getOptionOrTerm().getConstructor() != null;
		}
		return false;
	}
	
	/**
	 * Gets the name of the data sort.
	 * 
	 * @param decl
	 *            A function sort
	 * @return
	 */
	public static String dataSortName(Declaration decl) {
		return functionSortName(decl);
	}
	
	/**
	 * Whether the given object is a primitive
	 * 
	 * @param eobj
	 * @return
	 */
	public static boolean isPrimitive(EObject eobj) {
		if (eobj instanceof Term) {
			final Term term = (Term) eobj;
			return term.getEvaluator() != null;
		}
		return false;
	}
	
	/**
	 * Whether the given object is a variable
	 * 
	 * @param eobj
	 * @return
	 */
	public static boolean isVariable(EObject eobj) {
		if (eobj instanceof Term) {
			final Term term = (Term) eobj;
			return term.getVariable() != null;
		}
		return false;
	}
	
	
}
