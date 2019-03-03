package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pas_001_cqzone database table.
 * 
 */
@Entity
@Table(name="pas_001_cqzone")
@NamedQuery(name="Pas001Cqzone.findAll", query="SELECT p FROM Pas001Cqzone p")
public class Pas001Cqzone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	//bi-directional many-to-one association to CqZone
	@ManyToOne
	@JoinColumn(name="cq_zone_id", nullable=false)
	private CqZone cqZone;

	//bi-directional many-to-one association to Pas001
	@ManyToOne
	@JoinColumn(name="pas_001_id", nullable=false)
	private Pas001 pas001;

	public Pas001Cqzone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public CqZone getCqZone() {
		return this.cqZone;
	}

	public void setCqZone(CqZone cqZone) {
		this.cqZone = cqZone;
	}

	public Pas001 getPas001() {
		return this.pas001;
	}

	public void setPas001(Pas001 pas001) {
		this.pas001 = pas001;
	}

}