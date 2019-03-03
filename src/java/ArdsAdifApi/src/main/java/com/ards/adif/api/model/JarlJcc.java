package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the jarl_jcc database table.
 * 
 */
@Entity
@Table(name="jarl_jcc")
@NamedQuery(name="JarlJcc.findAll", query="SELECT j FROM JarlJcc j")
public class JarlJcc implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=30)
	private String prefecture;

	@Column(nullable=false, length=2)
	private String prefix;

	//bi-directional many-to-one association to JarlJccCity
	@OneToMany(mappedBy="jarlJcc")
	private List<JarlJccCity> jarlJccCities;

	public JarlJcc() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPrefecture() {
		return this.prefecture;
	}

	public void setPrefecture(String prefecture) {
		this.prefecture = prefecture;
	}

	public String getPrefix() {
		return this.prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public List<JarlJccCity> getJarlJccCities() {
		return this.jarlJccCities;
	}

	public void setJarlJccCities(List<JarlJccCity> jarlJccCities) {
		this.jarlJccCities = jarlJccCities;
	}

	public JarlJccCity addJarlJccCity(JarlJccCity jarlJccCity) {
		getJarlJccCities().add(jarlJccCity);
		jarlJccCity.setJarlJcc(this);

		return jarlJccCity;
	}

	public JarlJccCity removeJarlJccCity(JarlJccCity jarlJccCity) {
		getJarlJccCities().remove(jarlJccCity);
		jarlJccCity.setJarlJcc(null);

		return jarlJccCity;
	}

}