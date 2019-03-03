package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the pas_206_subdivision database table.
 * 
 */
@Entity
@Table(name="pas_206_subdivision")
@NamedQuery(name="Pas206Subdivision.findAll", query="SELECT p FROM Pas206Subdivision p")
public class Pas206Subdivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="before_date")
	private Date beforeDate;

	@Column(nullable=false, length=2)
	private String code;

	@Column(nullable=false, length=60)
	private String subdivision;

	//bi-directional many-to-one association to Pas206Region
	@ManyToOne
	@JoinColumn(name="pas_206_region_id", nullable=false)
	private Pas206Region pas206Region;

	public Pas206Subdivision() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBeforeDate() {
		return this.beforeDate;
	}

	public void setBeforeDate(Date beforeDate) {
		this.beforeDate = beforeDate;
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

	public Pas206Region getPas206Region() {
		return this.pas206Region;
	}

	public void setPas206Region(Pas206Region pas206Region) {
		this.pas206Region = pas206Region;
	}

}