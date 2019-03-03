package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_100 database table.
 * 
 */
@Entity
@Table(name="pas_100")
@NamedQuery(name="Pas100.findAll", query="SELECT p FROM Pas100 p")
public class Pas100 implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=1)
	private String code;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Dxcc
	@ManyToOne
	@JoinColumn(name="dxcc_id", nullable=false)
	private Dxcc dxcc;

	public Pas100() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSubdivision() {
		return this.subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public Dxcc getDxcc() {
		return this.dxcc;
	}

	public void setDxcc(Dxcc dxcc) {
		this.dxcc = dxcc;
	}

}