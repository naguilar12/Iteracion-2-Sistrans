package vos;

import java.util.List;

import org.codehaus.jackson.annotate.JsonProperty;

public class ListaCompaņias {

	@JsonProperty(value="companias")
	private List<CompaņiaTeatro> compaņias;

	public ListaCompaņias(@JsonProperty(value="companias")List<CompaņiaTeatro> compaņias) {
		super();
		this.compaņias = compaņias;
	}

	public List<CompaņiaTeatro> getCompaņias() {
		return compaņias;
	}

	public void setCompaņias(List<CompaņiaTeatro> compaņias) {
		this.compaņias = compaņias;
	}
}
